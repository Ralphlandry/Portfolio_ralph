#!/bin/bash
# Script de déploiement automatique pour le VPS

set -e

echo "🚀 Début du déploiement..."

# Variables d'environnement
DEPLOY_PATH="${DEPLOY_PATH:-.}"
GITHUB_USERNAME="${GITHUB_USERNAME:-$(echo $GITHUB_REPOSITORY | cut -d'/' -f1)}"
IMAGE_NAME="ghcr.io/$GITHUB_REPOSITORY:latest"

echo "📦 Configuration:"
echo "  - Path: $DEPLOY_PATH"
echo "  - Image: $IMAGE_NAME"

# Se connecter au registry si GITHUB_TOKEN est disponible
if [ ! -z "$GITHUB_TOKEN" ]; then
    echo "🔐 Connexion à GitHub Container Registry..."
    echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_USERNAME" --password-stdin
fi

echo "⬇️  Pull de la dernière image Docker..."
docker pull $IMAGE_NAME

echo "🛑 Arrêt du conteneur précédent..."
cd $DEPLOY_PATH
docker-compose down || true

echo "🔄 Démarrage du nouveau conteneur..."
docker-compose up -d

echo "⏳ Attente du démarrage..."
sleep 5

echo "✅ Déploiement terminé!"
echo "📊 État des conteneurs:"
docker-compose ps

echo ""
echo "📝 Logs récents:"
docker-compose logs --tail=20

echo ""
echo "✅ Application déployée avec succès!"
echo "🌐 Accessible sur: http://localhost:3000"
