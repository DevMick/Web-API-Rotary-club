# Rotary Club Manager API

Une API complète pour la gestion des clubs Rotary, développée en .NET 8 avec Entity Framework Core et PostgreSQL.

## 🚀 Fonctionnalités

- **Gestion des membres** : Inscription, profils, rôles et permissions
- **Gestion des réunions** : Planification, ordre du jour, présences
- **Gestion des événements** : Création, suivi, budgets
- **Gestion des galas** : Invités, tables, affectations
- **Gestion financière** : Budgets, cotisations, rapports
- **Communications** : Email, WhatsApp, notifications
- **Multi-tenant** : Support de plusieurs clubs

## 🛠️ Technologies utilisées

- **.NET 8** - Framework principal
- **Entity Framework Core** - ORM
- **PostgreSQL** - Base de données
- **JWT** - Authentification
- **Swagger/OpenAPI** - Documentation API
- **AutoMapper** - Mapping d'objets
- **FluentValidation** - Validation des données

## 📋 Prérequis

- .NET 8 SDK
- PostgreSQL 12+
- Visual Studio 2022 ou VS Code

## ⚙️ Configuration

### 1. Cloner le repository
```bash
git clone https://github.com/DevMick/Web-API-Rotary-club.git
cd Web-API-Rotary-club
```

### 2. Configuration de la base de données
1. Copiez `RotaryClubManager.API/appsettings.json.template` vers `RotaryClubManager.API/appsettings.json`
2. Modifiez les paramètres de connexion PostgreSQL dans `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=YOUR_HOST;Port=YOUR_PORT;Database=YOUR_DATABASE;Username=YOUR_USERNAME;Password=YOUR_PASSWORD;SSL Mode=Require"
  }
}
```

### 3. Configuration des services externes
Configurez les services suivants dans `appsettings.json`:

- **JWT Settings** : Clé secrète pour l'authentification
- **Email SMTP** : Configuration pour l'envoi d'emails
- **Meta WhatsApp** : Tokens pour l'intégration WhatsApp
- **Autres services** : Selon vos besoins

### 4. Migration de la base de données
```bash
cd RotaryClubManager.API
dotnet ef database update
```

### 5. Lancement de l'application
```bash
dotnet run
```

L'API sera accessible sur `https://localhost:5001` ou `http://localhost:5000`

## 📚 Documentation API

Une fois l'application lancée, accédez à la documentation Swagger :
- **Swagger UI** : `https://localhost:5001/swagger`

## 🔐 Authentification

L'API utilise JWT pour l'authentification. Voici un exemple de requête de connexion :

```bash
curl -X POST "https://localhost:5001/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "your-password"
  }'
```

## 📖 Exemples d'utilisation

### Gestion des invités de gala

```bash
# Récupérer les invités d'un gala
curl -X GET "https://localhost:5001/api/gala-invites/gala/{galaId}" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Créer un nouvel invité
curl -X POST "https://localhost:5001/api/gala-invites" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "galaId": "12345678-1234-1234-1234-123456789abc",
    "nom_Prenom": "Jean Dupont",
    "present": false
  }'
```

## 🏗️ Architecture

Le projet suit une architecture Clean Architecture avec :

- **RotaryClubManager.API** : Couche de présentation (Controllers, DTOs)
- **RotaryClubManager.Application** : Couche application (Services, Validators)
- **RotaryClubManager.Domain** : Couche domaine (Entities, Interfaces)
- **RotaryClubManager.Infrastructure** : Couche infrastructure (Data, Services externes)

## 🤝 Contribution

1. Fork le projet
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Poussez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📞 Support

Pour toute question ou support, contactez [votre-email@domain.com]

---

**Note importante** : Assurez-vous de ne jamais committer le fichier `appsettings.json` avec vos vraies données de configuration. Utilisez toujours le template et configurez vos variables d'environnement en production.
