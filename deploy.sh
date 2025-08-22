#!/bin/bash

# 🚀 Script de déploiement automatique pour Render
# Usage: ./deploy.sh

set -e

echo "🎯 Rotary Club Manager API - Déploiement Render"
echo "================================================"

# Vérifier si Git est initialisé
if [ ! -d ".git" ]; then
    echo "❌ Ce n'est pas un repository Git. Initialisation..."
    git init
    git branch -M master
fi

# Vérifier les fichiers requis
echo "🔍 Vérification des fichiers requis..."

required_files=("Dockerfile" "render.yaml" "RotaryClubManager.API/appsettings.json")
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Fichier manquant: $file"
        exit 1
    fi
done

echo "✅ Tous les fichiers requis sont présents"

# Vérifier la configuration
echo "🔧 Vérification de la configuration..."

if grep -q '""' RotaryClubManager.API/appsettings.json; then
    echo "⚠️  Des valeurs vides détectées dans appsettings.json"
    echo "   Ceci est normal pour le déploiement sur Render"
fi

# Ajouter tous les fichiers
echo "📦 Ajout des fichiers au repository..."
git add .

# Vérifier s'il y a des changements
if git diff --staged --quiet; then
    echo "ℹ️  Aucun changement à committer"
else
    echo "💾 Commit des changements..."
    git commit -m "🚀 Ready for Render deployment

- Dockerfile optimized for .NET 8
- Health check endpoint configured
- Environment variables ready
- PostgreSQL integration configured
- Auto-deployment setup complete"
fi

# Vérifier la remote origin
if git remote get-url origin >/dev/null 2>&1; then
    echo "🌐 Push vers le repository distant..."
    git push origin master
    
    echo ""
    echo "🎉 Déploiement préparé avec succès !"
    echo ""
    echo "📋 Prochaines étapes :"
    echo "1. Allez sur https://render.com"
    echo "2. Connectez votre compte GitHub"
    echo "3. Créez un nouveau Web Service"
    echo "4. Sélectionnez ce repository"
    echo "5. Render détectera automatiquement le Dockerfile"
    echo "6. Configurez les variables d'environnement :"
    echo "   - Email__SmtpUser"
    echo "   - Email__SmtpPassword"
    echo "   - Email__FromEmail"
    echo "   - Meta__AppId"
    echo "   - Meta__PhoneNumberId"
    echo "   - Meta__AccessToken"
    echo ""
    echo "🔗 URL de votre API : https://your-app-name.onrender.com"
    echo "📚 Documentation : https://your-app-name.onrender.com/swagger"
    echo "❤️  Health Check : https://your-app-name.onrender.com/health"
    
else
    echo "⚠️  Aucune remote origin configurée"
    echo ""
    echo "🔧 Pour configurer votre repository GitHub :"
    echo "1. Créez un nouveau repository sur GitHub"
    echo "2. Exécutez :"
    echo "   git remote add origin https://github.com/VOTRE-USERNAME/Web-API-Rotary-club.git"
    echo "   git push -u origin master"
    echo "3. Relancez ce script"
fi

echo ""
echo "✨ Script terminé !"
