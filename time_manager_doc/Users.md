# Documentation sur les users

## Routes

la route /api/users/time_credit/:id :
- calcul le nombre d'heures supp/manquantes du user dont l'id est passé en paramètre.
- chiffre donné en minute, positif si heures supp, négatif si heures en moins.

## Rôle

Le rôle d'un user doit correspondre à l'une des entrées dans la liste @roles du controleur. Pour le détail voir [user_controller.ex](..%2Ftime_manager%2Flib%2Ftime_manager_web%2Fcontrollers%2Fuser_controller.ex).

Si ce n'est pas le cas, l'API renverras une erreur.

# To Complete



1. Authentification

  1.1 Endpoint: /api/login
    Description : Permet à un utilisateur de se connecter.
    Méthode : POST
    Paramètres :
    email (string) : L'adresse e-mail de l'utilisateur.
    password (string) : Le mot de passe de l'utilisateur.
    Réponses :
    200 OK : Connexion réussie. Renvoie un jeton d'authentification.
    404 Not Found : Utilisateur non trouvé.
    422 Unprocessable Entity : E-mail ou mot de passe incorrect.

2. Gestion des Utilisateurs

  2.1 Endpoint: /api/users
    Description : Liste tous les utilisateurs.
    Méthode : GET
    Autorisations : Requiert un rôle "super_manager" ou "manager".
    Réponses :
    200 OK : Liste des utilisateurs récupérée avec succès.
    401 Unauthorized : Non autorisé.
    -----------------------------------------
    Description : Enregistre une nouvelle utilisateur.
    Méthode : POST
    Réponses :
    201 Created : Utilisateur enregistré avec succès.
  2.2 Endpoint: /api/users/:id
    Description : Opérations CRUD sur un utilisateur spécifique.
    Méthodes :
    GET : Récupère les détails d'un utilisateur.
    PUT : Met à jour les informations d'un utilisateur.
    DELETE : Supprime un utilisateur.
    Paramètres :
    id (string) : Identifiant de l'utilisateur.
    user (object) : Données utilisateur (pour les opérations de création et de mise à jour).
    Réponses :
    200 OK : Opération réussie.
    401 Unauthorized : Non autorisé.

3. Gestion du Temps Crédité

  3.1 Endpoint: /api/users/:id/time_credit
    Description : Récupère le temps crédité d'un utilisateur.
    Méthode : GET
    Paramètres :
    id (string) : Identifiant de l'utilisateur.
    Réponses :
    200 OK : Temps crédité récupéré avec succès.
    401 Unauthorized : Non autorisé.

4. Exemples d'utilisation

  4.1 Créer un nouvel utilisateur :
    POST /api/users
    Body: { "user": { "email": "example@email.com", "password": "securepassword" } }
  4.2 Mettre à jour les informations d'un utilisateur :
    PUT /api/users/123
    Body: { "user": { "role": "manager" } }
