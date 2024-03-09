#!/bin/bash

# Vérifier si le nombre d'arguments est correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 chemin_vers_la_clé_publique chemin_vers_le_fichier_config"
    exit 1
fi

# Assigner les arguments à des variables
PUBLIC_KEY_PATH="$1"
CONFIG_FILE="$2"

# Vérifier l'existence de la clé publique
if [ ! -f "$PUBLIC_KEY_PATH" ]; then
    echo "Le fichier de clé publique spécifié n'existe pas : $PUBLIC_KEY_PATH"
    exit 1
fi

# Vérifier l'existence du fichier de configuration
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Le fichier de configuration spécifié n'existe pas : $CONFIG_FILE"
    exit 1
fi

# Lire le fichier de configuration et extraire les informations
while IFS= read -r line; do
    case "$line" in
        Host\ *)
            HOST=${line#Host }
            ;;
        Hostname\ *)
            HOSTNAME=${line#Hostname }
            ;;
        User\ *)
            USER=${line#User }
            ;;
        *)
            if [[ -n $HOST && -n $HOSTNAME && -n $USER ]]; then
                echo "Déploiement de la clé publique sur $USER@$HOSTNAME ($HOST)"
                ssh-copy-id -i "$PUBLIC_KEY_PATH" "$USER@$HOSTNAME"
                # Réinitialiser les variables pour la prochaine entrée
                HOST=""
                HOSTNAME=""
                USER=""
            fi
            ;;
    esac
done < "$CONFIG_FILE"
