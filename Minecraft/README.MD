Ces scripts permettent la sauvegarde de serveur Minecraft sous Linux

backup.sh -> éteint le conteneur, copie, compresse et renomme le répertoire du serveur vers le répertoire de backup et relance le conteneur
message.sh -> apellé par le script backup.sh, fait un décompte dans le tchat du serveur pour prévenir de la sauvegarde

Dans la crontab, règle permettant de faire une sauvegarde tous les jours à 5h

Conteneur basé sur cette image : https://docker-minecraft-server.readthedocs.io/en/latest/#using-docker-compose

Les fichiers du serveur : /opt/minecraft/server
Les scripts de sauvegarde : /opt/minecrafr/tools
Les sauvegardes : /mnt/philips