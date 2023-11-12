Gestion des Tâches (Tasks)

1. Endpoint: /api/tasks
  Description :
  Gère les tâches enregistrées dans le système.

  1.1 GET /api/tasks
    Description :
    Récupère la liste des tâches.

    Autorisations :
    Requiert une identification.

    Réponses :
    200 OK : Liste des tâches récupérée avec succès.
    401 Unauthorized : Non autorisé.

  1.2 POST /api/tasks
    Description :
    Enregistre une nouvelle tâche.

    Autorisations :
    Requiert une identification.

    Réponses :
    201 Created : Tâche enregistrée avec succès.
    401 Unauthorized : Non autorisé.

    Spécificité :
    Le statut de la tâche est automatiquement défini comme faux lors de la création.
    Une tâche créée déclenche également la création d'une association entre l'utilisateur courant et cette tâche.

  1.3 GET /api/tasks/:id
    Description :
    Opérations CRUD sur une tâche spécifique.

    Paramètres :
    id (string) : Identifiant de la tâche.
    Autorisations :
    Requiert une identification et des autorisations spécifiques.

    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

  1.4 DELETE /api/tasks/:id
    Description :
    Supprime une tâche.

    Paramètres :
    id (string) : Identifiant de la tâche.
    Autorisations :
    Requiert une identification et des autorisations spécifiques.

    Réponses :
    204 No Content : Tâche supprimée avec succès.
    401 Unauthorized : Non autorisé.

2. Exemples d'utilisation

  2.1 Enregistrer une nouvelle tâche
    POST /api/tasks
    Body: {
      "task": {
        "title": "Titre de la tâche",
        "description": "Description détaillée de la tâche"
      }
    }

  2.2 Récupérer toutes les tâches pour un utilisateur spécifique
    GET /api/tasks/user/456

  2.3 Mettre à jour une tâche
    PUT /api/tasks/789
    Body: {
      "task": {
        "status": false
      }
    }
3. Opérations avancées

  3.1 Récupérer toutes les tâches pour une équipe spécifique
    Endpoint : /api/teams/:team_id/tasks

    Méthode : GET

    Paramètres :
    team_id (string) : Identifiant de l'équipe.
    Autorisations :
    Requiert un rôle "super_manager" ou "manager" pour l'équipe spécifiée.

    Réponses :
    200 OK : Liste des tâches de l'équipe récupérée avec succès.
    401 Unauthorized : Non autorisé.



Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
