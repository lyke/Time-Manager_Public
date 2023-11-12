# Documentation sur les working_times

## Particularité

À chaque fois qu'un employé dépointe (une clock avec un status à false), une working_time doit être créé avec la dernière clock de ce user.

De cette manière, une working time est un recap d'un créneau horaire où un employé a travaillé. Cette entité permet de faciliter les calculs des heures par la suite.

# To Complete

# Documentation sur les clocks

# To Do

1. Endpoint: /api/working_times

  Description :
  Gère les temps de travail enregistrés.

  1.1 GET /api/working_times
    Description :
    Récupère la liste des temps de travail.

    Autorisations :
    Requiert une identification.

    Réponses :
    200 OK : Liste des temps de travail récupérée avec succès.
    401 Unauthorized : Non autorisé.

  1.2 POST /api/working_times
    Description :
    Enregistre un nouveau temps de travail.

    Autorisations :
    Requiert une identification.

    Réponses :
    201 Created : Temps de travail enregistré avec succès.
    401 Unauthorized : Non autorisé.

  1.3 GET /api/working_times/:id
    Description :
    Opérations CRUD sur un temps de travail spécifique.

    Paramètres :

    id (string) : Identifiant du temps de travail.
    Autorisations :
    Requiert une identification et des autorisations spécifiques.

    Réponses :

    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

  1.4 DELETE /api/working_times/:id
    Description :
    Supprime un temps de travail.

    Paramètres :
    id (string) : Identifiant du temps de travail.
    Autorisations :
    Requiert une identification et des autorisations spécifiques.

    Réponses :
    204 No Content : Temps de travail supprimé avec succès.
    401 Unauthorized : Non autorisé.

2. Exemples d'utilisation

  2.1 Enregistrer un nouveau temps de travail
    POST /api/working_times
    Body: {
      "working_time": {
        "user_id": guid,
        "start": "2023-11-10T08:00:00",
        "end": "2023-11-10T17:00:00"
      }
    }
  2.2 Récupérer tous les temps de travail pour un utilisateur spécifique
    GET /api/working_times/user/456

  2.3 Mettre à jour un temps de travail
    PUT /api/working_times/789
    Body: {
      "working_time": {
        "status": false
      }
    }
3. Opérations avancées
  3.1 Récupérer tous les temps de travail pour une équipe spécifique

    Endpoint : /api/teams/:team_id/working_times

    Méthode : GET

    Paramètres :
    team_id (string) : Identifiant de l'équipe.
    Autorisations :
    Requiert un rôle "super_manager" ou "manager" pour l'équipe spécifiée.

    Réponses :
    200 OK : Liste des temps de travail de l'équipe récupérée avec succès.
    401 Unauthorized : Non autorisé.


Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
