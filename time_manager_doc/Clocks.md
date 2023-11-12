# Documentation sur les clocks

# To Do

1. Gestion des Horloges (Clocks)

  1.1 Endpoint: /api/clocks
    Description : Liste toutes les horloges enregistrées dans le système.
    Méthode : GET
    Autorisations : Requiert un rôle "super_manager".
    Réponses :
    200 OK : Liste des horloges récupérée avec succès.
    401 Unauthorized : Non autorisé.
    ----------------------------------------------------
    Description : Enregistre une nouvelle horloge.
    Méthode : POST
    Autorisations : Requiert d'être authentifié.
    Réponses :
    201 Created : Horloge enregistrée avec succès.
    401 Unauthorized : Non autorisé.
    Spécificité:
    - le statut alterne entre true et false à chaque création d'horloge pour un même utilisateur.
    - lorsque l'horloge a un statut false, un working time est crée avec les deux dernieres horloges et l'utilisateur courant.
  1.2 Endpoint: /api/clocks/:id
    Description : Opérations CRUD sur une horloge spécifique.
    Méthodes :
    GET : Récupère les détails d'une horloge.
    PUT : Met à jour les informations d'une horloge.
    DELETE : Supprime une horloge.
    Paramètres :
    id (string) : Identifiant de l'horloge.
    clock (object) : Données de l'horloge (pour les opérations de création et de mise à jour).
    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.
  1.3 Endpoint: /api/clocks/user/:user_id
    Description : Récupère toutes les horloges pour un utilisateur spécifique.
    Méthode : GET
    Paramètres :
    user_id (string) : Identifiant de l'utilisateur.
    Autorisations : Requiert un rôle "super_manager", "manager" pour l'équipe de l'utilisateur ou l'ID utilisateur correspondant.
    Réponses :
    200 OK : Liste des horloges de l'utilisateur récupérée avec succès.
    401 Unauthorized : Non autorisé.
  1.4 Endpoint: /api/clocks/user/:user_id/today
    Description : Récupère toutes les horloges pour un utilisateur spécifique aujourd'hui.
    Méthode : GET
    Paramètres :
    user_id (string) : Identifiant de l'utilisateur.
    Autorisations : Requiert un rôle "super_manager", "manager" pour l'équipe de l'utilisateur ou l'ID utilisateur correspondant.
    Réponses :
    200 OK : Liste des horloges de l'utilisateur aujourd'hui récupérée avec succès.
    401 Unauthorized : Non autorisé.

2. Exemples d'utilisation

  2.1 Enregistrer une nouvelle horloge :
    POST /api/clocks
    Body: { "clock": { "fk_user": guid, "time": "2023-11-10T12:30:00" } }
  2.2 Récupérer toutes les horloges pour un utilisateur spécifique :
    GET /api/clocks/user/456
  2.3 Mettre à jour l'état d'une horloge :
    PUT /api/clocks/789
    Body: { "clock": { "status": false } }

3. Opérations avancées

  3.1 Récupérer toutes les horloges pour une équipe spécifique :
    Endpoint: /api/teams/:team_id/clocks
    Méthode : GET
    Paramètres :
    team_id (string) : Identifiant de l'équipe.
    Autorisations : Requiert un rôle "super_manager" ou "manager" pour l'équipe spécifiée.
    Réponses :
    200 OK : Liste des horloges de l'équipe récupérée avec succès.
    401 Unauthorized : Non autorisé.


Note : Assurez-vous de fournir le jeton d'authentification dans les en-têtes de vos requêtes pour les endpoints nécessitant une authentification.
