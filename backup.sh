#!/bin/bash

# Variables
SERVER_PATH="/opt/minecraft/server"
BACKUP_PATH="/mnt/philips"
CONTAINER_NAME="minecraft-minecraft-1"
MAX_BACKUPS=3

# Vérifier si le dossier SERVER_PATH existe
if [ ! -d "$SERVER_PATH" ]; then
    echo "Le dossier '$SERVER_PATH' n'existe pas. Veuillez vérifier le chemin spécifié."
    exit 1
fi

#Lancement du cript de décompte
./message.sh

docker exec $CONTAINER_NAME rcon-cli stop
echo "Arrêt du conteneur '$CONTAINER_NAME'..."

# Attendre quelques secondes pour que le conteneur s'arrête
sleep 5
echo "Le conteneur '$CONTAINER_NAME' a été arrêté avec succès."

# Création d'un nom de fichier de sauvegarde avec la date et l'heure
BACKUP_NAME="backup_$(date +"%Y%m%d_%H%M%S")"

# Copie du répertoire du serveur
echo "Copie du répertoire du serveur"
sudo cp -r $SERVER_PATH $BACKUP_PATH/$BACKUP_NAME

# Compression du répertoire de sauvegarde
echo "Compression du répertoire de sauvegarde..."
sudo tar -czvf $BACKUP_PATH/$BACKUP_NAME.tar.gz -C $BACKUP_PATH $BACKUP_NAME

# Vérifier si le fichier de sauvegarde compressé existe
if [ ! -f "$BACKUP_PATH/$BACKUP_NAME.tar.gz" ]; then
    echo "Le fichier de sauvegarde compressé n'a pas été trouvé dans $BACKUP_PATH."
    exit 1
fi

# Suppression du répertoire de sauvegarde non compressé
sudo rm -r $BACKUP_PATH/$BACKUP_NAME
echo "Suppression du répertoire de sauvegarde non compressé..."


# Suppression des anciennes sauvegardes si nécessaire
echo "Suppression des anciennes sauvegardes..."
BACKUP_COUNT=$(ls -1t $BACKUP_PATH | grep backup | wc -l)
if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
    ls -1t $BACKUP_PATH/backup* | tail -n +$(($MAX_BACKUPS+1)) | xargs -I {} sudo rm -r {}
fi

# Redémarrage du serveur Minecraft
echo "Redémarrage du serveur Minecraft..."
docker start $CONTAINER_NAME

# Attendre quelques secondes pour que le conteneur redémarre
sleep 10

echo "Opération terminée."