#!/bin/bash

# Fonction de journalisation
log_activity() {
    local message=$1
    local log_file=""

    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        log_file="C:\\Windows\\System32\\LogFiles\\log_evt.log"
    else
        log_file="/var/log/log_evt.log"
    fi

    # Informations de log
    local datetime=$(date '+%Y-%m-%d %H:%M:%S')
    local username=$(whoami)
    local remote_user=$username
    local remote_host=$(hostname)
    local log_entry="$datetime - $username - $remote_user - $remote_host - $message"

    # Enregistrement dans le fichier log
    echo $log_entry >> $log_file
}

# Fonction pour se connecter en SSH
connect_ssh() {
    log_activity "Tentative de connexion SSH à $username@$hostname"
    echo "Connexion SSH en cours..."
    ssh $username@$hostname "echo Connexion SSH établie sur \`hostname\`"
    if [ $? -eq 0 ]; then
        log_activity "Connexion SSH réussie à $username@$hostname"
        return 0
    else
        log_activity "Échec de la connexion SSH à $username@$hostname"
        return 1
    fi
}

# Commande pour afficher les utilisateurs via SSH
show_users() {
    log_activity "Affichage des utilisateurs sur $hostname"
    ssh $username@$hostname "awk -F: '\$3 >= 1000 && \$1 != \"nobody\" {print \$1}' /etc/passwd"
}

# Fonction pour ajouter un utilisateur via SSH
add_user() {
    read -p "Entrez le nom de l'utilisateur à ajouter : " user_to_add
    read -s -p "Entrez le mot de passe sudo pour $username@$hostname : " password
    echo ""
    log_activity "Ajout de l'utilisateur $user_to_add sur $hostname"
    ssh $username@$hostname "echo '$password' | sudo -S useradd $user_to_add"
    if [ $? -eq 0 ]; then
        echo "Utilisateur $user_to_add créé avec succès."
        log_activity "Utilisateur $user_to_add créé avec succès sur $hostname"
    else
        echo "Échec de la création de l'utilisateur $user_to_add."
        log_activity "Échec de la création de l'utilisateur $user_to_add sur $hostname"
    fi
}

# Fonction pour supprimer un utilisateur via SSH
delete_user() {
    read -p "Entrez le nom de l'utilisateur à supprimer : " user_to_delete
    read -s -p "Entrez le mot de passe sudo pour $username@$hostname : " password
    echo ""
    log_activity "Suppression de l'utilisateur $user_to_delete sur $hostname"
    ssh $username@$hostname "echo '$password' | sudo -S deluser $user_to_delete"
    if [ $? -eq 0 ]; then
        echo "Utilisateur $user_to_delete supprimé avec succès."
        log_activity "Utilisateur $user_to_delete supprimé avec succès sur $hostname"
    else
        echo "Échec de la suppression de l'utilisateur $user_to_delete."
        log_activity "Échec de la suppression de l'utilisateur $user_to_delete sur $hostname"
    fi
}

# Fonction pour éteindre le serveur via SSH
shutdown_server() {
    read -p "Êtes-vous sûr de vouloir éteindre le serveur ? (oui/non) : " confirmation
    if [ "$confirmation" = "oui" ]; then
        read -s -p "Entrez le mot de passe sudo pour $username@$hostname : " password
        echo ""
        log_activity "Tentative d'extinction du serveur $hostname"
        ssh $username@$hostname "echo '$password' | sudo -S shutdown now"

        # Vérifier le statut de sortie de la commande SSH
        ssh_exit_status=$?
        if [ $ssh_exit_status -ne 0 ]; then
            echo "Serveur éteint."
            log_activity "Serveur $hostname éteint avec succès"
        else
            echo "Échec de l'arrêt du serveur."
            log_activity "Échec de l'arrêt du serveur $hostname"
        fi
    else
        echo "Opération annulée."
        log_activity "Extinction du serveur $hostname annulée par l'utilisateur"
    fi
}

# Fonction pour redémarrer le serveur via SSH
reboot_server() {
    read -p "Êtes-vous sûr de vouloir redémarrer le serveur ? (oui/non) : " confirmation
    if [ "$confirmation" = "oui" ]; then
        read -s -p "Entrez le mot de passe sudo pour $username@$hostname : " password
        echo ""
        log_activity "Tentative de redémarrage du serveur $hostname"
        ssh $username@$hostname "echo '$password' | sudo -S reboot"
        ssh_exit_status=$?
        
        if [ $ssh_exit_status -eq 0 ]; then
            echo "Le serveur est en cours de redémarrage."
            log_activity "Le serveur $hostname est en cours de redémarrage"
        else
            echo "Commande de redémarrage envoyée. La connexion SSH a été interrompue, le serveur est en cours de redémarrage."
            log_activity "Commande de redémarrage envoyée à $hostname, connexion SSH interrompue"
        fi
    else
        echo "Opération annulée."
        log_activity "Redémarrage du serveur $hostname annulé par l'utilisateur"
    fi
}

# Fonction pour afficher le menu
show_menu() {
    echo ""
    echo "Menu :"
    echo "1. Ajouter un utilisateur"
    echo "2. Supprimer un utilisateur"
    echo "3. Afficher les utilisateurs"
    echo "4. Éteindre le serveur"
    echo "5. Redémarrer le serveur"
    echo "6. Afficher les informations système"
    echo "7. Quitter"
}

# Fonction pour afficher les informations système via SSH
show_system_info() {
    log_activity "Affichage des informations système sur $hostname"
    # Obtenir la date du jour au format YYYY-MM-DD
    current_date=$(date +%F)
    # Définir le chemin du dossier Documents de l'utilisateur actuel
    documents_dir="$HOME/Documents"
    # Définir le nom du fichier avec la date du jour dans le dossier Documents
    output_file="$documents_dir/system_info_$current_date.txt"

    # Afficher les informations système et les enregistrer dans le fichier
    {
        echo "Informations système sur $hostname :"
        ssh $username@$hostname <<EOF
            echo "Utilisateurs :"
            awk -F: '\$3 >= 1000 && \$1 != "nobody" {print \$1}' /etc/passwd
            echo ""
            echo "Disque dur :"
            df -h
            echo ""
            echo "Architecture du processeur :"
            uname -m
            echo ""
            echo "Mémoire vive :"
            free -h
            echo ""
            echo "Adresse IP :"
            hostname -I
EOF
    } > "$output_file"

    # Afficher le contenu du fichier
    cat "$output_file"
    log_activity "Informations système enregistrées dans $output_file"
}

# Demander les identifiants SSH
echo "Entrez les informations de connexion SSH :"
read -p "Nom d'utilisateur : " username
read -p "Adresse IP ou nom de domaine : " hostname

# Boucle pour la connexion SSH
while ! connect_ssh; do
    echo "Échec de la connexion SSH. Veuillez réessayer."
    read -p "Nom d'utilisateur : " username
    read -p "Adresse IP ou nom de domaine : " hostname
done

echo "Connexion établie avec succès!"

# Afficher le menu principal
while true; do
    show_menu

    read -p "Choisissez une option (1/2/3/4/5/6/7) : " choice
    case $choice in
        1)
            echo "Option 1 : Ajouter un utilisateur"
            add_user
            ;;
        2)
            echo "Option 2 : Supprimer un utilisateur"
            delete_user
            ;;
        3)
            echo "Option 3 : Afficher les utilisateurs"
            echo "Liste des utilisateurs sur $hostname :"
            show_users
            ;;
        4)
            echo "Option 4 : Éteindre le serveur"
            shutdown_server
            ;;
        5)
            echo "Option 5 : Redémarrer le serveur"
            reboot_server
            ;;
        6)
            echo "Option 6 : Afficher les informations système"
            show_system_info
            echo "Les informations système ont été enregistrées dans $output_file"
            ;;
        7)
            echo "Option 7 : Au revoir!"
            log_activity "L'utilisateur a quitté le script"
            break
            ;;
        *)
            echo "Choix invalide. Veuillez choisir une option valide."
            ;;
    esac
done
