# Fonction pour se connecter en SSH
function Connect-SSH {
    param (
        [string]$username,
        [string]$hostname
    )
    Write-Host "Connexion SSH en cours..."
    $result = & ssh "$username@$hostname" "echo Connexion SSH établie sur $(hostname)"
    return $result
}

# Commande pour afficher les utilisateurs via SSH
function Show-Users {
    param (
        [string]$username,
        [string]$hostname
    )
    & ssh "$username@$hostname" "awk -F: '\$3 >= 1000 && \$1 != \"nobody\" {print \$1}' /etc/passwd"
}

# Fonction pour ajouter un utilisateur via SSH
function Add-User {
    param (
        [string]$username,
        [string]$hostname
    )
    $userToAdd = Read-Host "Entrez le nom de l'utilisateur à ajouter"
    $password = Read-Host "Entrez le mot de passe sudo pour $username@$hostname" -AsSecureString
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    Write-Host "Ajout de l'utilisateur $userToAdd..."
    $result = & ssh "$username@$hostname" "echo '$password' | sudo -S useradd $userToAdd"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Utilisateur $userToAdd créé avec succès."
    } else {
        Write-Host "Échec de la création de l'utilisateur $userToAdd."
    }
}

# Fonction pour supprimer un utilisateur via SSH
function Delete-User {
    param (
        [string]$username,
        [string]$hostname
    )
    $userToDelete = Read-Host "Entrez le nom de l'utilisateur à supprimer"
    $password = Read-Host "Entrez le mot de passe sudo pour $username@$hostname" -AsSecureString
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    Write-Host "Suppression de l'utilisateur $userToDelete..."
    $result = & ssh "$username@$hostname" "echo '$password' | sudo -S deluser $userToDelete"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Utilisateur $userToDelete supprimé avec succès."
    } else {
        Write-Host "Échec de la suppression de l'utilisateur $userToDelete."
    }
}

# Fonction pour afficher le menu
function Show-Menu {
    Write-Host ""
    Write-Host "Menu :"
    Write-Host "1. Ajouter un utilisateur"
    Write-Host "2. Supprimer un utilisateur"
    Write-Host "3. Afficher les utilisateurs"
    Write-Host "4. Quitter"
}

# Demander les identifiants SSH
Write-Host "Entrez les informations de connexion SSH :"
$username = Read-Host "Nom d'utilisateur"
$hostname = Read-Host "Adresse IP ou nom de domaine"

# Boucle pour la connexion SSH
while (-not (Connect-SSH -username $username -hostname $hostname)) {
    Write-Host "Échec de la connexion SSH. Veuillez réessayer."
    $username = Read-Host "Nom d'utilisateur"
    $hostname = Read-Host "Adresse IP ou nom de domaine"
}

Write-Host "Connexion établie avec succès!"

# Afficher le menu principal
while ($true) {
    Show-Menu
    $choice = Read-Host "Choisissez une option (1/2/3/4)"
    switch ($choice) {
        1 {
            Write-Host "Option 1 : Ajouter un utilisateur"
            Add-User -username $username -hostname $hostname
        }
        2 {
            Write-Host "Option 2 : Supprimer un utilisateur"
            Delete-User -username $username -hostname $hostname
        }
        3 {
            Write-Host "Option 3 : Afficher les utilisateurs"
            Write-Host "Liste des utilisateurs sur $hostname :"
            Show-Users -username $username -hostname $hostname
        }
        4 {
            Write-Host "Choix 4 : Au revoir!"
            break
        }
        default {
            Write-Host "Choix invalide. Veuillez choisir une option valide."
        }
    }
}
