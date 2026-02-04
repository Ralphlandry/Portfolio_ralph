# ✅ Checklist de Déploiement CI/CD

## 📋 Avant de commencer

- [ ] Avoir accès à votre VPS (IP + utilisateur SSH)
- [ ] Avoir un compte GitHub avec ce repository
- [ ] Avoir les droits admin sur votre VPS

---

## 🔑 ÉTAPE 1 : GitHub Secrets (5 min)

### Sur GitHub.com :
1. Allez sur votre repository → **Settings** → **Secrets and variables** → **Actions**
2. Cliquez sur **New repository secret** et ajoutez ces 4 secrets :

| Nom Secret | Valeur | Exemple |
|------------|--------|---------|
| `DEPLOY_HOST` | IP de votre VPS | `123.45.67.89` |
| `DEPLOY_USER` | Utilisateur SSH | `root` ou `ubuntu` |
| `DEPLOY_PATH` | Chemin sur le serveur | `/home/ralph/ralph-portfolio` |
| `DEPLOY_KEY` | Clé SSH privée complète | Voir fichier `C:\Users\ralph\.ssh\deploy_key` |

### ⚠️ Pour DEPLOY_KEY :
- Ouvrez `C:\Users\ralph\.ssh\deploy_key` dans Notepad
- Copiez **TOUT** le contenu (incluant BEGIN et END)
- Collez dans le secret GitHub

---

## 🖥️ ÉTAPE 2 : Configuration du VPS (15 min)

### Connectez-vous au VPS :
```bash
ssh votre-utilisateur@votre-ip-vps
```

### ⚠️ AlmaLinux / Rocky Linux / RHEL ?
Si votre VPS utilise AlmaLinux, Rocky Linux ou RHEL, **utilisez ce guide spécifique** :
📘 **[INSTALL-ALMALINUX.md](INSTALL-ALMALINUX.md)** - Guide complet pour distributions RHEL-based

### Option A : Script automatique (RECOMMANDÉ) ✨
```bash
# Téléchargez le script
wget https://raw.githubusercontent.com/VOTRE_USERNAME/ralph_portefolio/master/setup-vps.sh

# Rendez-le exécutable
chmod +x setup-vps.sh

# Exécutez-le
./setup-vps.sh
```

### Option B : Installation manuelle

#### Pour AlmaLinux / Rocky Linux / RHEL

📘 Consultez le guide complet : **[INSTALL-ALMALINUX.md](INSTALL-ALMALINUX.md)**

Ou installation rapide :

```bash
# 1. Installer Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

# 2. Configurer le pare-feu
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=3000/tcp
sudo firewall-cmd --reload
```

#### Pour Ubuntu / Debian

#### 1. Installer Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

#### 2. Installer Docker Compose

**Pour AlmaLinux** : Docker Compose est déjà installé ! Utilisez `docker compose` (avec espace).

**Pour Ubuntu/Debian** :
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### 3. Ajouter la clé SSH publique
```bash
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbhj7zTcQ9QmdgAPluAFGbVvrguuMQpN8yNqdR/aET5 ralph@DESKTOP-5DHN8LH" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

#### 4. Créer le dossier du projet
```bash
mkdir -p /home/ralph/ralph-portfolio
cd /home/ralph/ralph-portfolio
```

#### 5. Créer le docker-compose.yml
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

**⚠️ Remplacez `VOTRE_USERNAME_GITHUB` par votre username GitHub !**

#### 6. Se connecter à GitHub Container Registry
```bash
# Créez un token sur : https://github.com/settings/tokens
# Permission : read:packages

echo 'VOTRE_TOKEN' | docker login ghcr.io -u VOTRE_USERNAME --password-stdin
```

---

## 🚀 ÉTAPE 3 : Premier déploiement (2 min)

### Sur votre machine locale :

```bash
cd d:\projet_docker\Ralph_portefolio

# Assurez-vous d'être sur la branche master
git checkout master

# Commit et push
git add .
git commit -m "Setup CI/CD deployment"
git push origin master
```

### Vérification :
1. Allez sur GitHub → **Actions**
2. Vous verrez le workflow en cours d'exécution
3. Attendez que tout devienne vert ✅

---

## ✅ ÉTAPE 4 : Vérification

### Sur le VPS :
```bash
# Voir les conteneurs
docker ps

# Voir les logs
cd /home/ralph/ralph-portfolio
docker-compose logs -f
```

### Dans votre navigateur :
```
http://VOTRE_IP_VPS:3000
```

---

## 🎯 Déploiements futurs

À chaque fois que vous voulez déployer :

```bash
git add .
git commit -m "Votre message"
git push origin master
```

Le déploiement se fait **automatiquement** ! 🎉

---

## 🐛 Dépannage

### Le workflow GitHub Actions échoue ?

**Erreur de connexion SSH :**
- ✅ Vérifiez que `DEPLOY_KEY` contient toute la clé privée
- ✅ Vérifiez que la clé publique est dans `~/.ssh/authorized_keys` sur le VPS
- ✅ Vérifiez `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_PATH`

**Erreur Docker pull :**
- ✅ Assurez-vous d'être connecté à ghcr.io sur le VPS
- ✅ Vérifiez que le repository GitHub est bien configuré

### L'application ne démarre pas sur le VPS ?

```bash
# Vérifier les logs
docker-compose logs

# Vérifier le port
sudo netstat -tulpn | grep 3000

# Redémarrer
docker-compose restart
```

### Je ne peux pas accéder à l'application ?

```bash
# Pour AlmaLinux - Vérifier firewalld
sudo firewall-cmd --list-all
sudo firewall-cmd --permanent --add-port=3000/tcp
sudo firewall-cmd --reload

# Pour Ubuntu/Debian - Vérifier ufw
sudo ufw allow 3000/tcp

# Tester en local sur le VPS
curl http://localhost:3000

# Tester depuis l'extérieur
curl http://VOTRE_IP:3000
```

---

## 📞 Commandes utiles
**Note** : Sur AlmaLinux/Rocky/RHEL, utilisez `docker compose` (avec espace) au lieu de `docker-compose` (avec tiret).
```bash
# Voir l'état des conteneurs
docker ps

# Redémarrer l'application
docker-compose restart

# Arrêter l'application
docker-compose down

# Mettre à jour manuellement
docker-compose pull
docker-compose up -d

# Voir les logs en temps réel
docker-compose logs -f

# Nettoyer les anciennes images
docker image prune -a
```

---

## 🎓 Pour aller plus loin

### Installer Nginx (reverse proxy)
```bash
sudo apt install nginx -y
# Copiez la config depuis nginx-example.conf
```

### Installer SSL (Let's Encrypt)
```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d votre-domaine.com
```

---

## 📊 Résumé

✅ Configuration complétée
✅ CI/CD fonctionnel
✅ Déploiement automatique sur chaque push

**Votre workflow :**
```
Code local → git push → GitHub Actions → Build Docker → Deploy VPS → ✅
```

🎉 **Félicitations ! Votre portfolio est déployé avec CI/CD !**
