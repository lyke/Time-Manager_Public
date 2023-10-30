# Documentation sur les users

## Routes

la route /api/users/time_credit/:id :
- calcul le nombre d'heures supp/manquantes du user dont l'id est passé en paramètre.
- chiffre donné en minute, positif si heures supp, négatif si heures en moins.

## Rôle

Le rôle d'un user doit correspondre à l'une des entrées dans la liste @roles du controleur. Pour le détail voir [user_controller.ex](..%2Ftime_manager%2Flib%2Ftime_manager_web%2Fcontrollers%2Fuser_controller.ex).

Si ce n'est pas le cas, l'API renverras une erreur.

# To Complete