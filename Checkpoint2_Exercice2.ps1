
Write-Host "--- Début du script ---"
#Q2.9 Ajout de la fonction LOG au script
function Log
{
    param([string]$LogFile,[string]$Content)
    # Chemin du fichier log
    $log = "C:\Scripts\Log.log"
    # Vérifie si le fichier existe, sinon le crée
    If (-not (Test-Path -Path $log))
    {
        New-Item -ItemType File -Path $log | Out-Null
    }

    # Construit la ligne de journal
    $Date = Get-Date -Format "dd/MM/yyyy-HH:mm:ss"
    $User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $Content = $result
    $logLine = "$Date;$User;$Content"

    # Ajoute la ligne de journal au fichier
    Add-Content -Path $log -Value $logLine
}
#Q2.14 Modification de la longueur du mot de passe
#Function Random-Password ($length = 6)
Function Random-Password ($length = 12)
{
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}
#Q2.16 La fonction enléve les accents présent dans le CSV ,pour exemple le tréma du prénom Anaïs. 
Function ManageAccentsAndCapitalLetters
{
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"
#Q2.5 Modification de skip2 en skip1
#$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8  | Select-Object -Skip 2
#Q2.7 Modification des éléments pris en compte
 $Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description" -Encoding UTF8  | Select-Object -Skip 1
foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    #Q2.12 $Name
    If (-not(Get-LocalUser -Name $Name -ErrorAction SilentlyContinue))
    {
        $Pass = Random-Password
        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
      # Q2.6 $Description = "$($user.description) - $($User.fonction)"
        $Description = "$($user.description)
        $UserInfo = @{
            Name                 = "$Prenom.$Nom"
            FullName             = "$Prenom.$Nom"
            # Q2.6 Ajout Description
            Description          = "$Description"
            Password             = $Password
            AccountNeverExpires  = $true
            PasswordNeverExpires = $false
        }

        New-LocalUser @UserInfo
        #Q2.11
        Add-LocalGroupMember -Group "Utilisateur" -Member $Name
        #Q2.13 Expiration du mot de passe
        Set-LocalUser -Name $Name -PasswordNeverExpires 1
        #Q2.8 Ajout de l'affichage du mot de passe
        Write-Host "L'utilisateur $Name a été crée, le mot de passe est $Pass" -ForegroundColor Green
        $result = "Création de l'utilisateur $name"
    }
    #Q2.10 Modification du script
    else
    {
        write-host "L'utilisateur $Name éxiste déjà" -ForegroundColor Red
        $result = "Création utilisateur $name déja existant"
}


Write-Host "--- Fin du script ---"
#Q.2.15
Read-Host "Appuyez sur Entrée pour continuer"

