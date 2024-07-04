# Documentation d'Utilisation du Script de Gestion des Utilisateurs et du Serveur via SSH

## Introduction
Ce script Bash permet de gérer des utilisateurs et d'effectuer diverses actions sur un serveur distant via SSH. Il inclut une fonctionnalité de journalisation qui enregistre les activités effectuées dans des fichiers log spécifiques selon le système d'exploitation (Windows ou Linux).

## Prérequis
1. **Serveur SSH** : Le serveur distant doit avoir SSH activé et accessible.
2. **Accès Sudo** : L'utilisateur SSH doit avoir des privilèges sudo pour certaines opérations (ajout/suppression d'utilisateurs, redémarrage/arrêt du serveur).
3. **Permissions de Journalisation** : Le script doit avoir les permissions nécessaires pour écrire dans les fichiers log :
   - Windows : `C:\Windows\System32\LogFiles\log_evt.log`
   - Linux : `/var/log/log_evt.log`

## Fonctionnalités
1. **Connexion SSH** : Se connecter à un serveur distant via SSH.
2. **Ajouter un Utilisateur** : Ajouter un nouvel utilisateur sur le serveur distant.
3. **Supprimer un Utilisateur** : Supprimer un utilisateur existant sur le serveur distant.
4. **Afficher les Utilisateurs** : Afficher la liste des utilisateurs existants sur le serveur distant.
5. **Éteindre le Serveur** : Éteindre le serveur distant.
6. **Redémarrer le Serveur** : Redémarrer le serveur distant.
7. **Afficher les Informations Système** : Afficher et enregistrer les informations système du serveur distant.
8. **Journalisation des Activités** : Enregistrer les activités dans un fichier log.

## Utilisation

### 1. Téléchargement et Permissions
Copiez le script depuis le lien GitHub et créez un fichier `script.sh`, puis donnez-lui les permissions d'exécution avec la commande : chmod +x script.sh

### 2. Exécution du Script
Exécutez le script avec la commande : ./script.sh

### 3. Saisie des Identifiants SSH
À l'exécution, le script demande les informations de connexion SSH. Entrez les informations de connexion SSH :
Nom d'utilisateur : [votre_nom_d’utilisateur]
Adresse IP ou nom de domaine : [adresse_ip_ou_nom_de_domaine_du_serveur]
Connexion SSH : Le script tentera de se connecter au serveur distant. Le mot de passe de l’utilisateur cible vous sera demandé. En cas d'échec, il vous sera demandé de ressaisir les identifiants.

<img width="511" alt="Capture d’écran 2024-07-03 à 15 48 50" src="https://github.com/Salemnabil44/Projet2/assets/161028838/950cc90e-90f0-4438-a18a-8be9e6f5d6b6">

### 4. Menu Principal
Une fois connecté, le menu principal s’affiche :

Menu : 
1. Ajouter un utilisateur 
2. Supprimer un utilisateur 
3. Afficher les utilisateurs 
4. Éteindre le serveur 
5. Redémarrer le serveur 
6. Afficher les informations système 
7. Quitter

### 5. Sélection d’Option
Saisissez le numéro de l'option souhaitée et suivez les instructions à l’écran.
Détail des Options :
1. Ajouter un Utilisateur : Saisissez le nom de l'utilisateur à ajouter et le mot de passe sudo. Le script créera le nouvel utilisateur et enregistrera l'activité dans le fichier log.
2. Supprimer un Utilisateur : Saisissez le nom de l'utilisateur à supprimer et le mot de passe sudo. Le script supprimera l'utilisateur et enregistrera l'activité dans le fichier log.
3. Afficher les Utilisateurs : Le script affichera la liste des utilisateurs existants sur le serveur distant et enregistrera l'activité dans le fichier log.
4. Éteindre le Serveur : Confirmez l'opération et saisissez le mot de passe sudo. Le script éteindra le serveur et enregistrera l'activité dans le fichier log.
Attention : Éteindre le serveur est irrémédiable. Vous ne pourrez pas l’allumer à distance.
5. Redémarrer le Serveur : Confirmez l'opération et saisissez le mot de passe sudo. Le script redémarrera le serveur et enregistrera l'activité dans le fichier log.
6. Afficher les Informations Système : Le script affichera et enregistrera les informations système (utilisateurs, disque dur, processeur, mémoire vive, adresse IP) dans un fichier texte situé dans le dossier Documents de l'utilisateur local en fichier .txt.
7. Quitter : Le script terminera son exécution et enregistrera l'activité dans le fichier log.

## Journalisation
Le script enregistre les activités dans des fichiers log situés à :
Windows : C:\Windows\System32\LogFiles\log_evt.log
Linux : /var/log/log_evt.log
Les entrées de log incluent :
Date et heure de l'activité.
Nom de l'utilisateur local et distant.
Nom de l'ordinateur distant.
Description de l'activité.

## Conclusion 
Ce script Bash fournit une interface simple et efficace pour gérer les utilisateurs et les serveurs distants via SSH, tout en assurant une journalisation complète des activités. Assurez-vous d'avoir les permissions nécessaires pour écrire dans les fichiers log et d'exécuter des commandes sudo sur le serveur distant.
