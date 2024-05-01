#!/bin/bash

# Décompte dans le tchat

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 1 minute !
echo "Le serveur va redémarrer dans 1 minute !"
sleep 30

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 30 secondes !
echo "Le serveur va redémarrer dans 30 secondes !"
sleep 20

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 10 secondes ! 
echo "Le serveur va redémarrer dans 10 secondes !"
sleep 5

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 5 secondes ! 
echo "Le serveur va redémarrer dans 5 secondes !"
sleep 1

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 4 secondes !
echo "Le serveur va redémarrer dans 4 secondes !"
sleep 1

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 3 secondes !
echo "Le serveur va redémarrer dans 3 secondes !"
sleep 1

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 2 secondes !
echo "Le serveur va redémarrer dans 2 secondes !"
sleep 1

docker exec minecraft-minecraft-1 rcon-cli say Le serveur va redémarrer dans 1 secondes !
echo "Le serveur va redémarrer dans 1 secondes !"
sleep 1

docker exec minecraft-minecraft-1 rcon-cli say Bye bye !
echo "Bye bye !"