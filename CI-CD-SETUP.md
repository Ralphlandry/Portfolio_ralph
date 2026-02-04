# CI/CD Setup - Guide Complet

## 📋 Architecture

```
Local Development → Git Push → GitHub Actions → Docker Registry → VPS Deployment
```

---

## 🚀 ÉTAPE 1 : Préparation Locale

### 1.1 Installer Docker
- [Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Mac](https://docs.docker.com/desktop/install/mac-install/)
- [Linux](https://docs.docker.com/engine/install/)

### 1.2 Tester localement avec Docker

```bash
# Build l'image Docker
docker build -t ralph-portfolio:local .

# Run le conteneur
docker run -p 3000:3000 ralph-portfolio:local

# Accès: http://localhost:3000
```

### 1.3 Utiliser Docker Compose pour le développement

```bash
# Lancer le conteneur
docker-compose up -d

# Vérifier les logs
docker-compose logs -f

# Arrêter
docker-compose down
```

---

## 🔑 ÉTAPE 2 : Configuration GitHub

### 2.1 Repository Settings

1. Aller sur **GitHub → Your Repository → Settings**
2. Aller à **Secrets and variables → Actions**
3. Ajouter les secrets suivants:

```
DEPLOY_HOST          = IP de votre VPS (ex: 192.168.1.100)
DEPLOY_USER          = Utilisateur SSH (ex: root)
DEPLOY_KEY           = Clé SSH privée (voir 2.2)
DEPLOY_PATH          = Chemin sur le serveur (ex: /home/user/ralph-portfolio)
```

### 2.2 Générer une clé SSH pour le déploiement

Sur votre machine locale:

```bash
# Générer une clé SSH (sans passphrase pour l'automation)
ssh-keygen -t ed25519 -f deploy_key -N ""

# Afficher la clé privée (à mettre dans DEPLOY_KEY)
cat deploy_key

# Copier la clé publique sur le serveur
cat deploy_key.pub
```

Sur le VPS:

```bash
# Créer le dossier .ssh s'il n'existe pas
mkdir -p ~/.ssh

# Ajouter la clé publique
echo "CONTENU_DE_deploy_key.pub" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

### 2.3 Activer GitHub Actions

- Allez à **Actions** dans votre repo
- Cliquez sur **I understand my workflows, go ahead and enable them**

---

## 🖥️ ÉTAPE 3 : Configuration du VPS (Hébergement)

### 3.1 Prérequis sur le serveur

```bash
# Installer Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Installer Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
newgrp docker
```

### 3.2 Préparer le dossier de déploiement

```bash
# Se connecter au VPS
ssh user@votre-vps-ip

# Créer le dossier du projet
mkdir -p /home/user/ralph-portfolio
cd /home/user/ralph-portfolio

# Créer le docker-compose.yml sur le serveur
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    image: ghcr.io/VOTRE_USERNAME/ralph_portefolio:latest
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    container_name: ralph-portfolio

volumes:
  app_data:
EOF
```

### 3.3 Configurer Nginx comme reverse proxy (Optionnel mais recommandé)

```bash
# Installer Nginx
sudo apt update
sudo apt install nginx -y

# Créer la configuration
sudo nano /etc/nginx/sites-available/ralph-portfolio
```

Contenu du fichier:

```nginx
server {
    listen 80;
    server_name votre-domaine.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Activer la config:

```bash
# Créer le lien symbolique
sudo ln -s /etc/nginx/sites-available/ralph-portfolio /etc/nginx/sites-enabled/

# Tester la config
sudo nginx -t

# Redémarrer Nginx
sudo systemctl restart nginx
```

### 3.4 SSL avec Let's Encrypt (Optionnel mais recommandé)

```bash
# Installer Certbot
sudo apt install certbot python3-certbot-nginx -y

# Générer le certificat
sudo certbot --nginx -d votre-domaine.com

# Auto-renouvellement
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer
```

---

## 📤 ÉTAPE 4 : Workflow Déploiement

### Premier déploiement

1. **Pusher le code sur GitHub:**

```bash
git add .
git commit -m "Init CI/CD avec Docker"
git push origin main
```

2. **Vérifier les GitHub Actions:**
   - Allez à votre repo → Actions
   - Attendez que le workflow se termine
   - Vérifiez les logs pour les erreurs

3. **Vérifier le déploiement sur le VPS:**

```bash
# Sur le VPS
cd /home/user/ralph-portfolio
docker-compose logs -f
```

### Chaque fois que vous pushez sur main

Le workflow:
1. ✅ Clone le code
2. ✅ Build l'image Docker
3. ✅ Push l'image vers GitHub Container Registry
4. ✅ Se connecte au VPS via SSH
5. ✅ Pull la nouvelle image
6. ✅ Redémarre le conteneur

---

## 🐛 Dépannage

### Le workflow échoue au déploiement

```bash
# Vérifier les logs sur le VPS
docker-compose logs

# Vérifier la connexion SSH
ssh -i deploy_key deploy_user@host
```

### L'image ne se met pas à jour

```bash
# Force le pull de la dernière image
docker pull ghcr.io/VOTRE_USERNAME/ralph_portefolio:latest

# Redémarrer
docker-compose up -d
```

### Docker n'a pas d'espace disque

```bash
# Nettoyer les images non utilisées
docker system prune -a --volumes
```

---

## 📝 Fichiers créés

- `Dockerfile` - Build de l'image
- `.dockerignore` - Fichiers à ignorer
- `docker-compose.yml` - Orchestration locale
- `.github/workflows/ci-cd.yml` - Pipeline d'automatisation

---

## ✅ Checklist Finale

- [ ] Docker installé localement
- [ ] Clés SSH générées
- [ ] Secrets GitHub configurés
- [ ] VPS préparé (Docker + Docker Compose)
- [ ] Nginx configuré (optionnel)
- [ ] SSL configuré (optionnel)
- [ ] Premier push testé
- [ ] Déploiement automatique vérifié

---

## 🎯 Prochaines étapes recommandées

1. Ajouter une base de données (PostgreSQL, MongoDB)
2. Configurer des variables d'environnement
3. Ajouter des tests (Jest, Vitest)
4. Mettre en place une staging environment
5. Ajouter des notifications (Slack, Discord)
