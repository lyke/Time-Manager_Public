Gestion des Tâches Utilisateur (User Tasks)
1. Endpoint: /api/user_tasks
  Description :
  Gère les associations entre les utilisateurs et les tâches dans le système.

  1.1 GET /api/user_tasks
    Description :
    Récupère la liste des associations utilisateur-tâche.

    Autorisations :
    Requiert un rôle "super_manager".

    Réponses :
    200 OK : Liste des associations récupérée avec succès.
    401 Unauthorized : Non autorisé.

  1.2 POST /api/user_tasks
    Description :
    Crée une nouvelle association entre un utilisateur et une tâche.

    Autorisations :
    Requiert une identification.

    Réponses :
    201 Created : Association utilisateur-tâche créée avec succès.
    401 Unauthorized : Non autorisé.

  1.3 GET /api/user_tasks/:id
    Description :
    Opérations CRUD sur une association utilisateur-tâche spécifique.

    Paramètres :
    id (string) : Identifiant de l'association utilisateur-tâche.
    Autorisations :
    Requiert un rôle "super_manager".

    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

  1.4 DELETE /api/user_tasks/:id
    Description :
    Supprime une association utilisateur-tâche.

    Paramètres :
    id (string) : Identifiant de l'association utilisateur-tâche.
    Autorisations :
    Requiert un rôle "super_manager" ou "manager" pour l'utilisateur associé.

    Réponses :
    204 No Content : Association utilisateur-tâche supprimée avec succès.
    401 Unauthorized : Non autorisé.
2. Exemples d'utilisation

  2.1 Créer une nouvelle association utilisateur-tâche
    POST /api/user_tasks
    Body: {
      "user_task": {
        "user_id": "guid_utilisateur",
        "task_id": "guid_tache"
      }
    }

  2.2 Récupérer toutes les associations pour un utilisateur spécifique
    GET /api/user_tasks/user/456

  2.3 Mettre à jour une association utilisateur-tâche
    PUT /api/user_tasks/789
    Body: {
      "user_task": {
        "some_parameter": "nouvelle_valeur"
      }
    }



Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
