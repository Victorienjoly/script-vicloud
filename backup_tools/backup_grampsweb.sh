#!/bin/bash

# Variables
SERVER_PATH="/opt/grampsweb"
BACKUP_PATH="/mnt/philips/grampsweb"
CONTAINER_NAME="Gramps-Web"
MAX_BACKUPS=3

# Vérifier si le dossier SERVER_PATH existe
if [ ! -d "$SERVER_PATH" ]; then
    echo "Le dossier '$SERVER_PATH' n'existe pas. Veuillez vérifier le chemin spécifié."
    exit 1
fi

# Vérifier si le dossier BACKUP_PATH existe
if [ ! -d "$BACKUP_PATH" ]; then
    echo "Le dossier '$BACKUP_PATH' n'existe pas. Création du répertoire."
    mkdir $BACKUP_PATH
fi

# Arret des conteneurs
docker stop $CONTAINER_NAME
sleep 10

echo "Le conteneur '$CONTAINER_NAME' a été arrêté avec succès."

# Création d'un nom de fichier de sauvegarde avec la date et l'heure
BACKUP_NAME="backup_grampsweb_$(date +"%Y%m%d_%H%M%S")"

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

# Attendre quelques secondes pour que le conteneur redémarre
docker start $CONTAINER_NAME
sleep 10

echo "Opération terminée."