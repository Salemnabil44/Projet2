#!/bin/bash

# Variables
HOST="serveur_exemple.com"
USER="ton_nom_utilisateur"
SSH_KEY="~/.ssh/id_rsa"  # Remplace par le chemin de ta clé SSH privée si nécessaire

# Fonction pour se connecter via SSH et exécuter une commande
ssh_execute() {
    local COMMAND=$1
    ssh -i $SSH_KEY $USER@$HOST "$COMMAND"
    return $?
}

# Fonction pour ajouter un utilisateur
add_user() {
    echo "Entrez le nom du nouvel utilisateur : "
    read NEW_USER
    ssh_execute "sudo adduser $NEW_USER"
    if [ $? -eq 0 ]; then
        echo "Utilisateur $NEW_USER ajouté avec succès."
    else
        echo "Échec de l'ajout de l'utilisateur $NEW_USER."
    fi
}

# Fonction pour supprimer un utilisateur
delete_user() {
    echo "Entrez le nom de l'utilisateur à supprimer : "
    read USER_TO_DELETE
    ssh_execute "sudo deluser $USER_TO_DELETE"
    if [ $? -eq 0 ]; then
        echo "Utilisateur $USER_TO_DELETE supprimé avec succès."
    else
        echo "Échec de la suppression de l'utilisateur $USER_TO_DELETE."
    fi
}

# Fonction pour afficher la liste des utilisateurs
list_users() {
    ssh_execute "getent passwd | cut -d: -f1"
    if [ $? -eq 0 ]; then
        echo "Liste des utilisateurs affichée avec succès."
    else
        echo "Échec de l'affichage de la liste des utilisateurs."
    fi
}

# Fonction pour afficher le menu
show_menu() {
    echo "1) Ajouter un utilisateur"
    echo "2) Supprimer un utilisateur"
    echo "3) Afficher les utilisateurs"
    echo "4) Quitter"
}

# Script principal
while true; do
    show_menu
    echo "Sélectionnez une option : "
    read OPTION
    case $OPTION in
        1)
            add_user
            ;;
        2)
            delete_user
            ;;
        3)
            list_users
            ;;
        4)
            echo "Quitter..."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez entrer 1, 2, 3 ou 4."
            ;;
    esac
done

