Write-Host "--- Début du script ---"

function Log
{
    param([string]$LogFile,[string]$Content)
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
Function Random-Password ($length = 10){    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122
    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters{    param ([String]$String)    
    $StringWithoutAccent = $String -replace '[éèêë]', 'e' -replace '[àâä]', 'a' -replace '[îï]', 'i' -replace '[ôö]', 'o' -replace '[ùûü]', 'u'    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"$CsvFile = "$Path\Users.csv"$LogFile = "$Path\Log.log"
$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service", "description" -Encoding UTF8  | Select-Object -Skip 1
foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name $Name -ErrorAction SilentlyContinue))    {        $Pass = Random-Password        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description)"
        $UserInfo = @{
            Name                 = "$Prenom.$Nom"
            FullName             = "$Prenom.$Nom"
            Description          = "$Description"
            Password             = $Password
            AccountNeverExpires  = $true
            PasswordNeverExpires = $false
        }

        New-LocalUser @UserInfo
        Add-LocalGroupMember -Group "Utilisateurs" -Member $Name
        Set-LocalUser -Name $Name -PasswordNeverExpires 1
        Write-Host "L'utilisateur $Name a été crée, le mot de passe est $Pass" -ForegroundColor Green
        $result = "Création de l'utilisateur $name"
    }
    else
    {
        write-host "L'utilisateur $Name éxiste déjà" -ForegroundColor Red
        $result = "Création utilisateur $name déja existant"
    }
    Log -LogFile $LogFile -Content $result
}
Write-Host "--- Fin du script ---"
Read-Host "Appuyez sur Entrée pour confirmer"   
