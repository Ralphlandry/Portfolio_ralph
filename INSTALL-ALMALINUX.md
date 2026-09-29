# 🐧 Installation Docker sur AlmaLinux / Rocky Linux / RHEL

Guide spécifique pour l'installation de Docker sur les distributions basées sur RHEL.

## ⚡ Installation Rapide (Copier-Coller)

Connectez-vous à votre VPS AlmaLinux et exécutez ces commandes :

```bash
# 1. Installer les dépendances
sudo dnf -y install dnf-plugins-core

# 2. Ajouter le dépôt Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 3. Installer Docker et Docker Compose
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Démarrer et activer Docker
sudo systemctl start docker
sudo systemctl enable docker

# 5. Ajouter votre utilisateur au groupe docker
sudo usermod -aG docker $USER

# 6. Appliquer les changements (se reconnecter ou exécuter)
newgrp docker

# 7. Vérifier l'installation
docker --version
docker compose version
```

## 🔥 Configuration du pare-feu

AlmaLinux utilise `firewalld` par défaut :

```bash
# Ouvrir les ports nécessaires
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=3000/tcp

# Recharger le pare-feu
sudo firewall-cmd --reload

# Vérifier les ports ouverts
sudo firewall-cmd --list-all
```

## 📋 Configuration complète du VPS

### 1. Ajouter la clé SSH publique

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh

echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbhj7zTcQ9QmdgAPluAFGbVvrguuMQpN8yNqdR/aET5 ralph@DESKTOP-5DHN8LH" >> ~/.ssh/authorized_keys

chmod 600 ~/.ssh/authorized_keys
```

### 2. Créer le dossier de déploiement

```bash
# Créer le dossier (ajustez le chemin selon vos besoins)
mkdir -p /home/ralph/ralph-portfolio
cd /home/ralph/ralph-portfolio
```

### 3. Créer le fichier docker-compose.yml

**⚠️ Remplacez `VOTRE_USERNAME_GITHUB` par votre nom d'utilisateur GitHub**

```bash
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    image: ghcr.io/Ralphlandry/Portfolio_ralph:latest
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
```

### 4. Se connecter à GitHub Container Registry

```bash
# Créez d'abord un Personal Access Token sur GitHub :
# https://github.com/settings/tokens
# Permission nécessaire : read:packages

# Remplacez VOTRE_TOKEN et VOTRE_USERNAME. Ne commitez jamais un vrai token.
echo "VOTRE_TOKEN" | docker login ghcr.io -u VOTRE_USERNAME --password-stdin
```

## 🌐 Installation de Nginx (Optionnel)

```bash
# Installer Nginx
sudo dnf install -y nginx

# Démarrer et activer Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Ouvrir le port HTTP/HTTPS dans le pare-feu (déjà fait ci-dessus normalement)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

### Configuration Nginx pour reverse proxy

```bash
# Créer le fichier de configuration
sudo nano /etc/nginx/conf.d/ralph-portfolio.conf
```

Copiez cette configuration :

```nginx
server {
    listen 80;
    server_name votre-domaine.com;  # ou votre IP

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Testez et redémarrez Nginx :

```bash
# Tester la configuration
sudo nginx -t

# Redémarrer Nginx
sudo systemctl restart nginx
```

## 🔒 SSL avec Let's Encrypt (si vous avez un domaine)

```bash
# Installer EPEL et Certbot
sudo dnf install -y epel-release
sudo dnf install -y certbot python3-certbot-nginx

# Générer le certificat SSL
sudo certbot --nginx -d votre-domaine.com

# Le certificat sera automatiquement renouvelé
```

## ⚙️ SELinux (Important pour AlmaLinux)

Si vous rencontrez des problèmes de permissions, SELinux peut être la cause :

```bash
# Vérifier le statut de SELinux
getenforce

# Option 1 : Permettre à Docker de fonctionner avec SELinux
sudo setsebool -P container_manage_cgroup on

# Option 2 : Mettre SELinux en mode permissif (moins sécurisé)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
```

## ✅ Vérification de l'installation

```bash
# Vérifier Docker
docker --version
docker ps

# Vérifier Docker Compose
docker compose version

# Tester Docker
docker run hello-world

# Vérifier Nginx (si installé)
sudo systemctl status nginx

# Vérifier le pare-feu
sudo firewall-cmd --list-all
```

## 🚀 Premier déploiement

```bash
cd /home/ralph/ralph-portfolio

# Pull l'image Docker
docker pull ghcr.io/VOTRE_USERNAME_GITHUB/ralph_portefolio:latest

# Lancer le conteneur
docker compose up -d

# Vérifier les logs
docker compose logs -f

# Vérifier que ça fonctionne
curl http://localhost:3000
```

## 📝 Commandes Docker Compose sur AlmaLinux

**Important** : Sur AlmaLinux, utilisez `docker compose` (avec espace) au lieu de `docker-compose` (avec tiret).

```bash
# Démarrer les conteneurs
docker compose up -d

# Arrêter les conteneurs
docker compose down

# Voir les logs
docker compose logs -f

# Redémarrer
docker compose restart

# Voir l'état
docker compose ps

# Mettre à jour
docker compose pull
docker compose up -d
```

## 🐛 Dépannage

### Docker ne démarre pas

```bash
# Vérifier les logs
sudo journalctl -u docker

# Redémarrer Docker
sudo systemctl restart docker
```

### Problème de permissions

```bash
# S'assurer que l'utilisateur est dans le groupe docker
groups

# Si "docker" n'apparaît pas, se déconnecter et reconnecter
# ou exécuter :
newgrp docker
```

### Problème de pare-feu

```bash
# Vérifier les règles
sudo firewall-cmd --list-all

# Désactiver temporairement pour tester (NE PAS FAIRE EN PRODUCTION)
sudo systemctl stop firewalld

# Si ça fonctionne, c'est le pare-feu, ajoutez les règles appropriées
```

### SELinux bloque Docker

```bash
# Voir les erreurs SELinux
sudo ausearch -m avc -ts recent

# Autoriser Docker à fonctionner avec SELinux
sudo setsebool -P container_manage_cgroup on
```

## 📚 Ressources

- [Documentation Docker](https://docs.docker.com/engine/install/centos/)
- [AlmaLinux Wiki](https://wiki.almalinux.org/)
- [Firewalld Documentation](https://firewalld.org/)
- [SELinux Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/using_selinux/)

---

**Conseil** : Une fois l'installation terminée, retournez au fichier [CHECKLIST.md](CHECKLIST.md) pour continuer le déploiement CI/CD.
