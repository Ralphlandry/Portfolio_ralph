#!/bin/bash
# Script de déploiement rapide pour le VPS

set -e

echo " Début du déploiement..."

# Variables
DEPLOY_PATH="${DEPLOY_PATH:-.}"
IMAGE_NAME="ghcr.io/$GITHUB_REPOSITORY:latest"

echo " Pull de la dernière image Docker..."
docker pull $IMAGE_NAME

echo " Arrêt du conteneur précédent..."
cd $DEPLOY_PATH
docker-compose down || true

echo " Démarrage du nouveau conteneur..."
docker-compose up -d

echo " Déploiement terminé!"
echo " Logs:"
docker-compose logs -f --tail=20
