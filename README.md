# 🎯 Rotary Club Manager API

Une API complète pour la gestion des clubs Rotary, développée en .NET 8 avec Entity Framework Core et PostgreSQL. **Déployable gratuitement sur Render !**

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## 🚀 Fonctionnalités

- **Gestion des membres** : Inscription, profils, rôles et permissions
- **Gestion des réunions** : Planification, ordre du jour, présences
- **Gestion des événements** : Création, suivi, budgets
- **Gestion des galas** : Invités, tables, affectations
- **Gestion financière** : Budgets, cotisations, rapports
- **Communications** : Email, WhatsApp, notifications
- **Multi-tenant** : Support de plusieurs clubs

## 🛠️ Stack Technique

- **.NET 8** - Framework principal
- **Entity Framework Core** - ORM
- **PostgreSQL** - Base de données
- **JWT** - Authentification
- **Docker** - Containerisation
- **Swagger/OpenAPI** - Documentation API

## 🌐 Déploiement sur Render (GRATUIT)

### Option 1 : Déploiement automatique (Recommandé)

1. **Fork ce repository** sur votre compte GitHub

2. **Connectez-vous à [Render](https://render.com)** avec votre compte GitHub

3. **Créez un nouveau Web Service** :
   - Sélectionnez votre fork du repository
   - Choisissez la branche `master`
   - Render détectera automatiquement le `Dockerfile`

4. **Configuration automatique** :
   - Le fichier `render.yaml` configure automatiquement :
     - Base de données PostgreSQL gratuite
     - Variables d'environnement
     - Health checks

5. **Variables d'environnement à configurer** :
   ```
   Email__SmtpUser=your-email@gmail.com
   Email__SmtpPassword=your-app-password
   Email__FromEmail=your-email@gmail.com
   Meta__AppId=your-meta-app-id
   Meta__PhoneNumberId=your-phone-number-id
   Meta__AccessToken=your-meta-access-token
   ```

### Option 2 : Déploiement manuel

1. **Clonez le repository** :
   ```bash
   git clone https://github.com/DevMick/Web-API-Rotary-club.git
   cd Web-API-Rotary-club
   ```

2. **Créez un Web Service sur Render** :
   - Environment: `Docker`
   - Build Command: (laissez vide)
   - Start Command: (laissez vide)

3. **Créez une base PostgreSQL** :
   - Nom: `rotary-club-db`
   - Plan: Free

4. **Configurez les variables d'environnement** dans Render

## 🔧 Configuration Locale

### Prérequis
- .NET 8 SDK
- Docker (optionnel)
- PostgreSQL (pour développement local)

### Installation locale

1. **Cloner le repository** :
   ```bash
   git clone https://github.com/DevMick/Web-API-Rotary-club.git
   cd Web-API-Rotary-club
   ```

2. **Configurer appsettings.json** :
   ```json
   {
     "ConnectionStrings": {
       "DefaultConnection": "Host=localhost;Port=5432;Database=rotaryclub;Username=postgres;Password=yourpassword"
     },
     "JwtSettings": {
       "Secret": "your-super-secret-jwt-key-32-characters-minimum"
     }
   }
   ```

3. **Restaurer les packages** :
   ```bash
   dotnet restore
   ```

4. **Appliquer les migrations** :
   ```bash
   cd RotaryClubManager.API
   dotnet ef database update
   ```

5. **Lancer l'application** :
   ```bash
   dotnet run
   ```

### 🐳 Avec Docker

```bash
# Build l'image
docker build -t rotary-club-api .

# Run le container
docker run -p 8080:8080 \
  -e ConnectionStrings__DefaultConnection="your-connection-string" \
  -e JwtSettings__Secret="your-jwt-secret" \
  rotary-club-api
```

## 📚 Documentation API

- **Production** : `https://your-app-name.onrender.com/swagger`
- **Local** : `https://localhost:5001/swagger`
- **Health Check** : `https://your-app-name.onrender.com/health`

## 🔐 Authentification

### Connexion
```bash
curl -X POST "https://your-app-name.onrender.com/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "your-password"
  }'
```

### Utilisation du token
```bash
curl -X GET "https://your-app-name.onrender.com/api/gala-invites/gala/{galaId}" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## 📖 Exemples d'API

### Gestion des invités de gala

```bash
# Lister les invités
GET /api/gala-invites/gala/{galaId}

# Créer un invité
POST /api/gala-invites
{
  "galaId": "uuid",
  "nom_Prenom": "Jean Dupont",
  "present": false
}

# Affecter une table
POST /api/gala-invites/{inviteId}/affecter-table
{
  "tableId": "uuid"
}
```

## 🏗️ Architecture

```
├── RotaryClubManager.API/          # Controllers, DTOs, Middleware
├── RotaryClubManager.Application/  # Services, Validators
├── RotaryClubManager.Domain/       # Entities, Interfaces
├── RotaryClubManager.Infrastructure/ # Data, External Services
├── Dockerfile                      # Configuration Docker
├── render.yaml                     # Configuration Render
└── README.md                       # Documentation
```

## 🚀 Commandes Git Setup Complet

```bash
# 1. Cloner et setup initial
git clone https://github.com/DevMick/Web-API-Rotary-club.git
cd Web-API-Rotary-club

# 2. Créer votre propre repository
git remote remove origin
git remote add origin https://github.com/VOTRE-USERNAME/Web-API-Rotary-club.git

# 3. Configurer et pousser
git add .
git commit -m "Initial setup for Render deployment"
git push -u origin master

# 4. Déployer sur Render
# Connectez votre repository GitHub à Render
# Le déploiement se fera automatiquement !
```

## 🔒 Variables d'Environnement Render

### Obligatoires (générées automatiquement)
- `ConnectionStrings__DefaultConnection` - Base de données PostgreSQL
- `JwtSettings__Secret` - Clé JWT (générée automatiquement)

### À configurer manuellement
- `Email__SmtpUser` - Votre email SMTP
- `Email__SmtpPassword` - Mot de passe d'application
- `Email__FromEmail` - Email expéditeur
- `Meta__AppId` - ID application Meta
- `Meta__PhoneNumberId` - ID téléphone WhatsApp
- `Meta__AccessToken` - Token d'accès Meta

## 🆓 Limites du Plan Gratuit Render

- **Web Service** : 750h/mois (suffisant pour un projet)
- **PostgreSQL** : 1GB de stockage
- **Bandwidth** : 100GB/mois
- **Sleep après 15min** d'inactivité (réveil automatique)

## 🤝 Contribution

1. Fork le projet
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez (`git commit -m 'Add AmazingFeature'`)
4. Poussez (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📝 Licence

MIT License - voir [LICENSE](LICENSE)

## 📞 Support

- **Issues** : [GitHub Issues](https://github.com/DevMick/Web-API-Rotary-club/issues)
- **Discussions** : [GitHub Discussions](https://github.com/DevMick/Web-API-Rotary-club/discussions)

---

⭐ **N'oubliez pas de star le repository si il vous aide !**
