#Q2.5 remplacement skip 2 par skip 1
Write-Host "--- Début du script ---"

#Q2.9 Ajout de la fonction LOG au script
function Log {
    param([string]$LogFile, [string]$Content)
    
    # Chemin du fichier log
    $log = "C:\Scripts\Log.log"
    
    # Vérifie si le fichier existe, sinon le crée
    If (-not (Test-Path -Path $log)) {
        New-Item -ItemType File -Path $log | Out-Null
    }

    # Construit la ligne de journal
    $Date = Get-Date -Format "dd/MM/yyyy-HH:mm:ss"
    $User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $logLine = "$Date;$User;$Content"

    # Ajoute la ligne de journal au fichier
    Add-Content -Path $log -Value $logLine
}

#Q2.14 Modification de la longueur du mot de passe
Function Random-Password {
    param([int]$length = 12)
    
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = Get-Random -Count $length -InputObject ($punc + $digits + $letters) |
        ForEach-Object { [char]$_ } -join ""
    
    return $password
}

#Q2.16 La fonction enlève les accents présent dans le CSV ,pour exemple le tréma du prénom Anaïs. 
Function ManageAccentsAndCapitalLetters {
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    
    return $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"

#Q2.7 Modification des éléments pris en compte
$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","description" -Encoding UTF8 | Select-Object -Skip 1

foreach ($User in $Users) {
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.nom
    $Name = "$Prenom.$Nom"
    
    #Q2.12 $Name
    If (-not(Get-LocalUser -Name $Name -ErrorAction SilentlyContinue)) {
        $Pass = Random-Password
        $Password = ConvertTo-SecureString $Pass -AsPlainText -Force
        
        # Q2.6 $Description = "$($user.description) - $($User.fonction)"
        $Description = "$($user.description)"
        $UserInfo = @{
            Name                 = $Name
            FullName             = "$Prenom $Nom"
            # Q2.6 Ajout Description
            Description          = $Description
            Password             = $Password
            AccountNeverExpires  = $true
            PasswordNeverExpires = $false
        }

        New-LocalUser @UserInfo
        
        #Q2.11
        Add-LocalGroupMember -Group "Utilisateurs" -Member $Name
        
        #Q2.13 Expiration du mot de passe
        Set-LocalUser -Name $Name -PasswordNeverExpires $true
        
        #Q2.8 Ajout de l'affichage du mot de passe
        Write-Host "L'utilisateur $Name a été créé, le mot de passe est $Pass" -ForegroundColor Green
        $result = "Création de l'utilisateur $Name"
    }
    #Q2.10 Modification du script
    else {
        Write-Host "L'utilisateur $Name existe déjà" -ForegroundColor Red
        $result = "Création utilisateur $Name déjà existant"
    }
    
    Log -LogFile $LogFile -Content $result
}

Write-Host "--- Fin du script ---"
Read-Host "Appuyez sur Entrée pour confirmer"
