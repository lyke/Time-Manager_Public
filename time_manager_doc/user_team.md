# User_team

Le schéma user_team correspond à la table many to many liant les users aux teams dans la BDD.

Le lien est automatique (géré par le framework) pour tous les get.

Pour créer un lien entre un user et une team (ajouté un user à une team), il faut créer un nouveau user_team via le POST api/user_team. Cela créera une ligne dans la table user_team et donc ajoutera un user à une team.


1. Gestion des Relations Utilisateur-Équipe

  1.1 Endpoint: /api/user_teams
    Description : Liste toutes les relations utilisateur-équipe.
    Méthode : GET
    Autorisations : Requiert un rôle "super_manager".
    Réponses :
    200 OK : Liste des relations utilisateur-équipe récupérée avec succès.
    401 Unauthorized : Non autorisé.
    ------------------------------------------------------
    Description : Enregistre une nouvelle relations utilisateur-équipe.
    Méthode : POST
    Autorisations : Requiert un rôle "super_manager".
    Réponses :
    201 Created : Opération réussie.
    401 Unauthorized : Non autorisé.
  1.2 Endpoint: /api/user_teams/:id
    Description : Opérations CRUD sur une relation utilisateur-équipe spécifique.
    Méthodes :
    GET : Récupère les détails d'une relation utilisateur-équipe.
    PUT : Met à jour les informations d'une relation utilisateur-équipe.
    DELETE : Supprime une relation utilisateur-équipe.
    Paramètres :
    id (string) : Identifiant de la relation utilisateur-équipe.
    user_team (object) : Données de la relation utilisateur-équipe (pour les opérations de création et de mise à jour).
    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

2. Exemples d'utilisation

  2.1 Créer une nouvelle relation utilisateur-équipe :
    POST /api/user_teams
    Body: { "user_team": { "user_id": guid, "team_id": guid, "role": "user" } }
  2.2 Mettre à jour les informations d'une relation utilisateur-équipe :
    PUT /api/user_teams/789
    Body: { "user_team": { "role": "responsable" } }

3. Exemples d'opérations avancées

  3.1 Récupérer les détails de toutes les relations d'une équipe :
    Endpoint: /api/teams/:team_id/user_teams
    Méthode : GET
    Paramètres :
    team_id (string) : Identifiant de l'équipe.
    Réponses :
    200 OK : Liste des relations utilisateur-équipe pour l'équipe spécifiée.
    401 Unauthorized : Non autorisé.


Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
