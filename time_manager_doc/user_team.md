# User_team

Le schéma user_team correspond à la table many to many liant les users aux teams dans la BDD.

Le lien est automatique (géré par le framework) pour tous les get.

Pour créer un lien entre un user et une team (ajouté un user à une team), il faut créer un nouveau user_team via le POST api/user_team. Cela créera une ligne dans la table user_team et donc ajoutera un user à une team.