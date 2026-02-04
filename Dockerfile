# Stage 1: Build
FROM node:22-alpine AS builder

WORKDIR /app

# Copier les fichiers de dépendances
COPY package.json package-lock.json ./

# Installer les dépendances
RUN npm ci

# Copier le code source
COPY . .

# Construire l'application
RUN npm run build

# Stage 2: Runtime
FROM node:22-alpine

WORKDIR /app

# Installer un serveur HTTP léger (serve)
RUN npm install -g serve

# Copier les fichiers compilés du stage de build
COPY --from=builder /app/dist ./dist

# Copier les fichiers publics si nécessaire
COPY public ./public

# Exposer le port
EXPOSE 3000

# Commande de démarrage - Écouter sur toutes les interfaces
CMD ["serve", "-s", "dist", "-l", "tcp://0.0.0.0:3000"]
