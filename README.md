# TSSR - Projet 2 - The Scripting Project

## Introduction

Ce projet consiste à développer des scripts permettant d'exécuter des tâches sur des machines distantes au sein d'un réseau. Il s'agit de mettre en place une architecture client/serveur en utilisant des scripts bash et PowerShell.

## Objectifs

### Objectifs principaux
- Exécuter un script PowerShell sur un serveur Windows Server 2022 ciblant des ordinateurs Windows.
- Exécuter un script shell sur un serveur Debian 12 ciblant des ordinateurs Ubuntu.

### Objectifs secondaires
- Cibler une machine cliente avec un type d'OS différent depuis un serveur.

## Configuration des Machines

### Serveurs

**Serveur Windows Server 2022**
- Nom : SRVWIN01
- Compte : Administrator
- Mot de passe : Azerty1*
- IP fixe : 172.16.10.5/24

**Serveur Debian 12**
- Nom : SRVLX01
- Compte : root
- Mot de passe : Azerty1*
- IP fixe : 172.16.10.10/24

### Clients

**Client Windows 10**
- Nom : CLIWIN01
- Compte utilisateur : wilder (admin local)
- Mot de passe : Azerty1*
- IP fixe : 172.16.10.20/24

**Client Ubuntu 22.04 LTS**
- Nom : CLILIN01
- Compte utilisateur : wilder (sudo)
- Mot de passe : Azerty1*
- IP fixe : 172.16.10.30/24

## Fonctionnalités des Scripts

**Script PowerShell (.ps1)**  
Ce script est exécuté sur le serveur Windows et permet d'effectuer diverses actions sur les clients Windows.

**Script Shell (.sh)**  
Ce script est exécuté sur le serveur Debian et permet d'effectuer diverses actions sur les clients Ubuntu.

**Menu de Navigation**
- **Cible** : Ordinateur ou utilisateur
- **Actions** : Création/suppression de compte, arrêt/redémarrage des ordinateurs, etc.
- **Informations** : Récupération de données telles que la date de dernière connexion, version de l'OS, etc.

## Journalisation

Les événements sont enregistrés dans des fichiers de log :

- **Serveur Windows** : `C:\Windows\System32\LogFiles\log_evt.log`
- **Serveur Linux** : `/var/log/log_evt.log`

## Documentation

### Documentation Générale
- Présentation du projet
- Membres du groupe et rôles
- Choix techniques et versions des OS
- Difficultés et solutions
- Améliorations possibles

### Documentation Administrateur
- Prérequis techniques
- Instructions d'installation et de configuration
- FAQ pour les problèmes courants

### Documentation Utilisateur
- Utilisation de base et avancée des scripts
- FAQ pour les problèmes d'utilisation courants

## Conclusion

Ce projet vise à renforcer les compétences en scripting et en gestion d'architecture client/serveur, tout en mettant l'accent sur la documentation et la collaboration en équipe.
