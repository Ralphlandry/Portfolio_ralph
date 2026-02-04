#!/bin/bash
# Script d'installation et de configuration du VPS
# À exécuter sur le serveur VPS

set -e

echo "🚀 Configuration du VPS pour Ralph Portfolio"
echo "=============================================="

# Couleurs pour les messages
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables à configurer
read -p "Entrez votre nom d'utilisateur GitHub: " GITHUB_USERNAME
read -p "Entrez le chemin de déploiement (ex: /home/ralph/ralph-portfolio): " DEPLOY_PATH
read -p "Avez-vous un nom de domaine? (y/n): " HAS_DOMAIN

echo ""
echo -e "${YELLOW}1. Détection du système d'exploitation${NC}"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    echo "Système détecté: $PRETTY_NAME"
else
    OS="unknown"
    echo "Système non identifié, tentative d'installation générique..."
fi

echo ""
echo -e "${YELLOW}2. Installation de Docker${NC}"
if ! command -v docker &> /dev/null; then
    echo "Installation de Docker..."
    
    if [[ "$OS" == "almalinux" || "$OS" == "rocky" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
        # Installation pour RHEL-based distributions
        echo "Installation pour distribution RHEL-based..."
        sudo dnf -y install dnf-plugins-core
        sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        COMPOSE_CMD="docker compose"
    else
        # Installation générique (Ubuntu, Debian, etc.)
        echo "Installation générique..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        rm -f get-docker.sh
        COMPOSE_CMD="docker-compose"
    fi
    
    sudo usermod -aG docker $USER
    echo -e "${GREEN}✓ Docker installé${NC}"
else
    echo -e "${GREEN}✓ Docker déjà installé${NC}"
    # Détecter quelle commande compose utiliser
    if docker compose version &> /dev/null; then
        COMPOSE_CMD="docker compose"
    else
        COMPOSE_CMD="docker-compose"
    fi
fi

echo ""
echo -e "${YELLOW}3. Installation de Docker Compose${NC}"
if [[ "$COMPOSE_CMD" == "docker compose" ]]; then
    echo -e "${GREEN}✓ Docker Compose déjà installé (plugin)${NC}"
    docker compose version
elif ! command -v docker-compose &> /dev/null; then
    echo "Installation de Docker Compose standalone..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    COMPOSE_CMD="docker-compose"
    echo -e "${GREEN}✓ Docker Compose installé${NC}"
else
    echo -e "${GREEN}✓ Docker Compose déjà installé${NC}"
fi

echo ""
echo -e "${YELLOW}4. Configuration du dossier .ssh${NC}"
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
echo -e "${GREEN}✓ Dossier .ssh configuré${NC}"

echo ""
echo -e "${YELLOW}5. Création du dossier de déploiement${NC}"
mkdir -p "$DEPLOY_PATH"
cd "$DEPLOY_PATH"
echo -e "${GREEN}✓ Dossier créé: $DEPLOY_PATH${NC}"

echo ""
echo -e "${YELLOW}6. Création du fichier docker-compose.yml${NC}"
cat > docker-compose.yml << EOF
version: '3.8'

services:
  app:
    image: ghcr.io/$GITHUB_USERNAME/ralph_portefolio:latest
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    container_name: ralph-portfolio
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
EOF
echo -e "${GREEN}✓ docker-compose.yml créé${NC}"

echo ""
echo -e "${YELLOW}7. Configuration du pare-feu${NC}"
if command -v ufw &> /dev/null; then
    sudo ufw allow 22/tcp    # SSH
    sudo ufw allow 80/tcp    # HTTP
    sudo ufw allow 443/tcp   # HTTPS
    sudo ufw allow 3000/tcp  # Application
    echo -e "${GREEN}✓ Ports ouverts (22, 80, 443, 3000)${NC}"
elif command -v firewall-cmd &> /dev/null; then
    # Firewall pour RHEL-based (AlmaLinux, Rocky, CentOS)
    sudo firewall-cmd --permanent --add-service=ssh
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --permanent --add-port=3000/tcp
    sudo firewall-cmd --reload
    echo -e "${GREEN}✓ Ports ouverts dans firewalld (22, 80, 443, 3000)${NC}"
else
    echo "Aucun pare-feu détecté, configurez manuellement si nécessaire"
fi

echo ""
echo -e "${YELLOW}8. Installation de Nginx${NC}"
if ! command -v nginx &> /dev/null; then
    if [[ "$OS" == "almalinux" || "$OS" == "rocky" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
        sudo dnf install -y nginx
    else
        sudo apt update
        sudo apt install nginx -y
    fi
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo -e "${GREEN}✓ Nginx installé${NC}"
else
    echo -e "${GREEN}✓ Nginx déjà installé${NC}"
fi

if [ "$HAS_DOMAIN" = "y" ]; then
    read -p "Entrez votre nom de domaine: " DOMAIN_NAME
    
    echo ""
    echo -e "${YELLOW}9. Configuration de Nginx pour $DOMAIN_NAME${NC}"
    
    if [[ "$OS" == "almalinux" || "$OS" == "rocky" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
        # Configuration pour RHEL-based
        sudo bash -c "cat > /etc/nginx/conf.d/ralph-portfolio.conf << 'NGINXEOF'
server {
    listen 80;
    server_name $DOMAIN_NAME;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
NGINXEOF"
    else
        # Configuration pour Debian/Ubuntu
        sudo bash -c "cat > /etc/nginx/sites-available/ralph-portfolio << 'NGINXEOF'
server {
    listen 80;
    server_name $DOMAIN_NAME;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
NGINXEOF"
        sudo ln -sf /etc/nginx/sites-available/ralph-portfolio /etc/nginx/sites-enabled/
    fi
    
    sudo nginx -t && sudo systemctl restart nginx
    echo -e "${GREEN}✓ Nginx configuré pour $DOMAIN_NAME${NC}"
    
    echo ""
    echo -e "${YELLOW}10. Installation de Certbot (Let's Encrypt)${NC}"
    if ! command -v certbot &> /dev/null; then
        if [[ "$OS" == "almalinux" || "$OS" == "rocky" || "$OS" == "rhel" || "$OS" == "centos" ]]; then
            sudo dnf install -y epel-release
            sudo dnf install -y certbot python3-certbot-nginx
        else
            sudo apt install certbot python3-certbot-nginx -y
        fi
        echo -e "${GREEN}✓ Certbot installé${NC}"
        
        echo ""
        read -p "Voulez-vous générer un certificat SSL maintenant? (y/n): " GEN_SSL
        if [ "$GEN_SSL" = "y" ]; then
            sudo certbot --nginx -d $DOMAIN_NAME
            echo -e "${GREEN}✓ Certificat SSL généré${NC}"
        fi
    else
        echo -e "${GREEN}✓ Certbot déjà installé${NC}"
    fi
fi

echo ""
echo "=============================================="
echo -e "${GREEN}✅ Configuration terminée!${NC}"
echo "=============================================="
echo ""
echo "📝 Prochaines étapes:"
echo ""
echo "1. Ajoutez la clé SSH publique à ~/.ssh/authorized_keys"
echo "   Copiez la clé depuis votre machine locale:"
echo "   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbhj7zTcQ9QmdgAPluAFGbVvrguuMQpN8yNqdR/aET5 ralph@DESKTOP-5DHN8LH"
echo ""
echo "   Puis exécutez:"
echo "   echo 'VOTRE_CLE_PUBLIQUE' >> ~/.ssh/authorized_keys"
echo ""
echo "2. Créez un Personal Access Token sur GitHub:"
echo "   https://github.com/settings/tokens"
echo "   Permissions: read:packages"
echo ""
echo "3. Connectez-vous au GitHub Container Registry:"
echo "   echo 'VOTRE_TOKEN' | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin"
echo ""
echo "4. Configurez les secrets GitHub:"
echo "   DEPLOY_HOST = $(curl -s ifconfig.me 2>/dev/null || echo 'VOTRE_IP')"
echo "   DEPLOY_USER = $(whoami)"
echo "   DEPLOY_PATH = $DEPLOY_PATH"
echo "   DEPLOY_KEY = [votre clé SSH privée]"
echo ""
echo "5. Utilisez '$COMPOSE_CMD' pour gérer vos conteneurs"
echo "   Exemple: cd $DEPLOY_PATH && $COMPOSE_CMD up -d"
echo ""
echo "6. Poussez votre code sur GitHub (branche master)"
echo ""
if [ "$HAS_DOMAIN" = "y" ]; then
    echo "🌐 Votre site sera accessible sur: https://$DOMAIN_NAME"
else
    echo "🌐 Votre site sera accessible sur: http://$(curl -s ifconfig.me):3000"
fi
echo ""
