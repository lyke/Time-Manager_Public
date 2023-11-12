# Documentation sur les teams

Une team est une entité simple composé seulement d'un id et d'un nom d'équipe.

Puisqu'une team à plusieurs employés, et qu'un employé peut-être dans plusieurs team, il faut en plus une table many to many. Voir [Schema_general.md](Schema_general.md)

1. Gestion des Équipes

  1.1 Endpoint: /api/teams
    Description : Liste toutes les équipes.
    Méthode : GET
    Autorisations : Requiert un rôle "super_manager" ou "manager".
    Réponses :
    200 OK : Liste des équipes récupérée avec succès.
    401 Unauthorized : Non autorisé.
    -----------------------------------------------
    Description : Enregistre une nouvelle équipe.
    Méthode : POST
    Autorisations : Requiert un rôle "super_manager".
    Réponses :
    201 Created : Horloge enregistrée avec succès.
    401 Unauthorized : Non autorisé.
  1.2 Endpoint: /api/teams/:id
    Description : Opérations CRUD sur une équipe spécifique.
    Méthodes :
    GET : Récupère les détails d'une équipe.
    PUT : Met à jour les informations d'une équipe.
    DELETE : Supprime une équipe.
    Paramètres :
    id (string) : Identifiant de l'équipe.
    team (object) : Données de l'équipe (pour les opérations de création et de mise à jour).
    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

2. Exemples d'utilisation

  2.1 Créer une nouvelle équipe :
    POST /api/teams
    Body: { "team": { "name": "Nouvelle Équipe", "description": "Description de l'équipe" } }
  2.2 Mettre à jour les informations d'une équipe :
    PUT /api/teams/123
    Body: { "team": { "description": "Nouvelle description de l'équipe" } }

3. Exemples d'opérations avancées

  3.1 Récupérer les détails d'une équipe avec ses membres :
    Endpoint: /api/teams/:id/members
    Méthode : GET
    Paramètres :
    id (string) : Identifiant de l'équipe.
    Réponses :
    200 OK : Liste des membres de l'équipe récupérée avec succès.
    401 Unauthorized : Non autorisé.



Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
