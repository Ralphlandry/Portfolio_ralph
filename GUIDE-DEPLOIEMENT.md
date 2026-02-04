# 🚀 Guide de Déploiement CI/CD - Ralph Portfolio

## ✅ Étape 1 : Configuration GitHub Secrets (OBLIGATOIRE)

### 1. Accéder aux Secrets GitHub
1. Allez sur votre repository GitHub
2. Cliquez sur **Settings** (Paramètres)
3. Dans le menu de gauche, allez à **Secrets and variables** → **Actions**
4. Cliquez sur **New repository secret**

### 2. Ajouter les 4 secrets suivants :

#### Secret 1 : `DEPLOY_KEY`
- **Nom** : `DEPLOY_KEY`
- **Valeur** : Copiez TOUTE la clé privée ci-dessous (incluant les lignes BEGIN et END)
```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAA
MwAAAAtzc2gtZW
QyNTUxOQAAACD24Y+803EPUJnYAD5bgBRm1b64LrjEKTfMjanUf2hE+Q
AAAJjVcIO41XCD
uAAAAAtzc2gtZWQyNTUxOQAAACD24Y+803EPUJnYAD5bgBRm1b64LrjE
KTfMjanUf2hE+Q
AAAEB0F5dxJQ+CMZ/jIJkD5IdiaM2FqCAFNoB+MPIMmB7If/bhj7zTcQ
9QmdgAPluAFGbV
vrguuMQpN8yNqdR/aET5AAAAFXJhbHBoQERFU0tUT1AtNURITjhMSA==
-----END OPENSSH PRIVATE KEY-----
```

#### Secret 2 : `DEPLOY_HOST`
- **Nom** : `DEPLOY_HOST`
- **Valeur** : L'adresse IP de votre VPS (ex: `123.45.67.89`)

#### Secret 3 : `DEPLOY_USER`
- **Nom** : `DEPLOY_USER`
- **Valeur** : Votre nom d'utilisateur SSH sur le VPS (ex: `root` ou `ubuntu`)

#### Secret 4 : `DEPLOY_PATH`
- **Nom** : `DEPLOY_PATH`
- **Valeur** : Le chemin sur le serveur (ex: `/home/ralph/ralph-portfolio`)

---

## ✅ Étape 2 : Configuration du VPS

### 1. Connectez-vous à votre VPS
```bash
ssh votre-utilisateur@votre-vps-ip
```

### 2. Installer Docker

#### Pour AlmaLinux / Rocky Linux / RHEL
```bash
# Installer les dépendances
sudo dnf -y install dnf-plugins-core

# Ajouter le dépôt Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Installer Docker
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Démarrer et activer Docker
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER

# Appliquer les changements
newgrp docker

# Vérifier l'installation
docker --version
```

#### Pour Ubuntu / Debian
```bash
# Télécharger et installer Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER

# Appliquer les changements
newgrp docker
```

### 3. Installer Docker Compose

#### Pour AlmaLinux / Rocky Linux / RHEL (déjà inclus)
```bash
# Docker Compose est déjà installé via docker-compose-plugin
# Utilisez 'docker compose' (avec espace) au lieu de 'docker-compose'
docker compose version
```

#### Pour Ubuntu / Debian (installation manuelle)
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Vérifier l'installation
docker-compose --version
```

**Note** : Sur AlmaLinux, utilisez `docker compose` (avec espace) au lieu de `docker-compose` (avec tiret).

### 4. Ajouter la clé SSH publique
```bash
# Créer le dossier .ssh si nécessaire
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Ajouter la clé publique
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbhj7zTcQ9QmdgAPluAFGbVvrguuMQpN8yNqdR/aET5 ralph@DESKTOP-5DHN8LH" >> ~/.ssh/authorized_keys

# Sécuriser les permissions
chmod 600 ~/.ssh/authorized_keys
```

### 5. Créer le dossier de déploiement
```bash
# Remplacez le chemin par celui que vous avez mis dans DEPLOY_PATH
mkdir -p /home/ralph/ralph-portfolio
cd /home/ralph/ralph-portfolio
```

### 6. Créer le fichier docker-compose.yml sur le VPS
```bash
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  app:
    image: ghcr.io/VOTRE_USERNAME_GITHUB/ralph_portefolio:latest
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    container_name: ralph-portfolio
EOF
```

**⚠️ IMPORTANT** : Remplacez `VOTRE_USERNAME_GITHUB` par votre nom d'utilisateur GitHub

### 7. Se connecter à GitHub Container Registry
```bash
# Créer un Personal Access Token sur GitHub :
# GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token
# Permissions nécessaires : read:packages

# Se connecter
echo "VOTRE_TOKEN" | docker login ghcr.io -u VOTRE_USERNAME_GITHUB --password-stdin
```

---

## ✅ Étape 3 : Configuration Nginx (Optionnel mais recommandé)

### 1. Installer Nginx
```bash
sudo apt update
sudo apt install nginx -y
```

### 2. Configurer le reverse proxy
```bash
sudo nano /etc/nginx/sites-available/ralph-portfolio
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

### 3. Activer la configuration
```bash
# Créer le lien symbolique
sudo ln -s /etc/nginx/sites-available/ralph-portfolio /etc/nginx/sites-enabled/

# Tester la configuration
sudo nginx -t

# Redémarrer Nginx
sudo systemctl restart nginx
```

### 4. Configurer SSL avec Let's Encrypt (si vous avez un nom de domaine)
```bash
# Installer Certbot
sudo apt install certbot python3-certbot-nginx -y

# Générer le certificat SSL
sudo certbot --nginx -d votre-domaine.com

# Le certificat sera auto-renouvelé
```

---

## ✅ Étape 4 : Premier Déploiement

### Option A : Via GitHub (automatique)
1. Assurez-vous que tous les secrets sont configurés
2. Commitez et poussez vos changements sur la branche `master`
```bash
git add .
git commit -m "Setup CI/CD"
git push origin master
```
3. Allez sur GitHub → Actions pour voir le workflow en cours
4. Le déploiement sera automatique !

### Option B : Test manuel (pour vérifier)
Sur votre VPS :
```bash
cd /home/ralph/ralph-portfolio

# Pull l'image
docker pull ghcr.io/VOTRE_USERNAME_GITHUB/ralph_portefolio:latest

# Lancer le conteneur
docker-compose up -d

# Vérifier les logs
docker-compose logs -f
```

---

## 🔍 Vérification et Tests

### 1. Vérifier que l'application fonctionne
```bash
# Sur le VPS
curl http://localhost:3000

# Ou depuis votre navigateur
http://votre-vps-ip:3000
# ou avec Nginx
http://votre-domaine.com
```

### 2. Vérifier les logs
```bash
cd /home/ralph/ralph-portfolio
docker-compose logs -f
```

### 3. Commandes utiles
```bash
# Voir les conteneurs en cours
docker ps

# Redémarrer l'application
docker-compose restart

# Arrêter l'application
docker-compose down

# Mettre à jour l'application
docker pull ghcr.io/VOTRE_USERNAME_GITHUB/ralph_portefolio:latest
docker-compose down
docker-compose up -d
```

---

## 🎯 Workflow Automatique

À chaque `git push` sur la branche `master` :

1. ✅ GitHub Actions se déclenche
2. ✅ Build de l'image Docker
3. ✅ Push vers GitHub Container Registry
4. ✅ Connexion SSH au VPS
5. ✅ Pull de la nouvelle image
6. ✅ Redémarrage du conteneur
7. ✅ Application mise à jour !

---

## 🐛 Dépannage

### Le workflow échoue ?
- Vérifiez que tous les secrets GitHub sont correctement configurés
- Vérifiez que la clé SSH est bien ajoutée sur le VPS
- Regardez les logs dans GitHub Actions

### L'application ne démarre pas ?
```bash
# Vérifier les logs
docker-compose logs

# Vérifier si le port est déjà utilisé
sudo netstat -tulpn | grep 3000
```

### Nginx ne fonctionne pas ?
```bash
# Vérifier les logs Nginx
sudo tail -f /var/log/nginx/error.log

# Tester la config
sudo nginx -t
```

---

## 📝 Notes Importantes

1. **Sécurité** : Ne partagez JAMAIS votre clé privée SSH
2. **GitHub Token** : Gardez votre Personal Access Token secret
3. **Firewall** : Assurez-vous que les ports 80, 443, et 3000 sont ouverts sur votre VPS
4. **Mise à jour** : Le déploiement est automatique à chaque push sur `master`

---

## 📚 Ressources

- [Documentation Docker](https://docs.docker.com/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Let's Encrypt](https://letsencrypt.org/)
- [Nginx Documentation](https://nginx.org/en/docs/)
