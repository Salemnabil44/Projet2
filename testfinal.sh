#!/bin/bash

# Vérifier si le script est exécuté en tant que root
if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être exécuté en tant que root"
  exit 1
fi

# Fonction pour la connexion SSH
connexion_ssh() {
  read -p "Entrez le nom d'utilisateur pour la connexion SSH: " username
  read -p "Entrez l'adresse IP ou le nom d'hôte: " hostname
  ssh "$username"@"$hostname"
}

while true; do
  # Afficher le menu
  echo "======================"
  echo "   Menu Utilisateur   "
  echo "======================"
  echo "1. Ajouter un utilisateur"
  echo "2. Supprimer un utilisateur"
  echo "3. Afficher les utilisateurs"
  echo "4. Connexion SSH"
  echo "5. Quitter"
  echo -n "Choisissez une option [1-5]: "
  read choix

  case $choix in
    1)
      # Ajouter un utilisateur
      echo -n "Entrez le nom d'utilisateur à ajouter: "
      read username
      if id "$username" &>/dev/null; then
        echo "L'utilisateur '$username' existe déjà."
      else
        useradd -m "$username"
        if [ $? -eq 0 ]; then
          echo "L'utilisateur '$username' a été ajouté."
          echo -n "Entrez le mot de passe pour $username: "
          read -s password
          echo
          # Utiliser chpasswd pour définir le mot de passe
          echo "$username:$password" | chpasswd
          if [ $? -eq 0 ]; then
            echo "Le mot de passe a été défini avec succès pour l'utilisateur '$username'."
          else
            echo "Échec de la définition du mot de passe pour l'utilisateur '$username'."
          fi
        else
          echo "Échec de l'ajout de l'utilisateur '$username'."
        fi
      fi
      ;;
    2)
      # Supprimer un utilisateur
      echo -n "Entrez le nom d'utilisateur à supprimer: "
      read username
      if id "$username" &>/dev/null; then
        userdel -r "$username" 2>/dev/null
        if [ $? -eq 0 ]; then
          echo "L'utilisateur '$username' a été supprimé."
        else
          echo "Échec de la suppression de l'utilisateur '$username'."
        fi
      else
        echo "L'utilisateur '$username' n'existe pas."
      fi
      ;;
    3)
      # Afficher les utilisateurs
      echo "Liste des utilisateurs sur le système (après les 55 premières lignes) :"
      tail -n +56 /etc/passwd | cut -d: -f1
      ;;
    4)
      # Connexion SSH
      connexion_ssh
      ;;
    5)
      # Quitter le script
      echo "Quitter."
      exit 0
      ;;
    *)
      # Option invalide
      echo "Option invalide. Veuillez choisir une option entre 1 et 5."
      ;;
  esac

  echo ""
done
