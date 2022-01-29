#==============================================================================
# Password changing script to allow quick password changes for users on AD
# Also pre-generates an email to their manager, enables the accound, and
# sets password change on next logon to true.
# Note: this works on the default domain, add -Server flags if that is
# appropriate for your environment.
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

<# PASSWORD CHANGER #>
<# WARNING: This script does not use secure-strings or anything like that, it is
intended explicitly to let the Service Desk operator see, read, confirm, and
read out to the user their new password in an environment where shoulder-surfing 
or more exotic surveillance isn't a problem. DO NOT USE in a situation where 
that sort of thing is an issue, obviously. #>

function passwd {
    param
    ([Parameter(Mandatory, HelpMessage = "Enter the user's SAM account name.")]
        $UserVar,
        [Parameter(Mandatory, HelpMessage = "Enter the desired password.")]
        $passwordVar) 

    Write-Host "§§ Password Changer §§" -ForegroundColor Magenta
    Write-Host "==================================================================" -ForegroundColor Magenta
    Write-Host "NOTE: CONFIRM USER IS NOT WORKING FROM HOME!" -ForegroundColor Red
    Write-Host "Does this look good?" -ForegroundColor Red
    Write-Output $uservar $passwordvar
    Read-Host "Press enter to continue..."
    Write-Host "==================================================================" -ForegroundColor Magenta

    Write-Host " "
    Write-Host "= Changing user's password =" -ForegroundColor Magenta
    Set-ADAccountPassword -Verbose -Identity $userVar -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$passwordVar" -Force) -Confirm -ErrorAction Stop; 
    Start-Sleep -m 350;

    Write-Host " "
    Write-Host "= Setting ChangePasswordAtLogon to true =" -ForegroundColor Magenta
    Set-ADUser -Verbose -Identity $uservar -ChangePasswordAtLogon $true -Confirm; 
    Start-Sleep -m 350;

    Write-Host " "
    Write-Host "= Enabling user's account =" -ForegroundColor Magenta
    Enable-ADAccount $userVar -Confirm -Verbose; 
    Start-Sleep -m 350;

    Get-ADUser $userVar -properties manager, lockedout, emailaddress, PasswordLastSet, AccountExpirationDate
    $emailName = get-aduser $userVar -Properties DisplayName | Select-Object DisplayName | Format-List
    Get-ADUser $userVar -properties * | Select-Object Manager, @{Name = "ManagerEmail"; Expression = { (get-aduser -property emailaddress $_.manager).emailaddress } }

    Write-Host "`nEmail for manager:"-ForegroundColor Magenta
    Write-Host "Hi,`n`nWe've received a request from a user to reset their password.`nPlease see the user's name, username, and new password below."
    Write-Output $emailName;
    Write-Host "Username: $userVar`nPassword: $passwordVar`n`nIf you have any difficulties or questions, please contact the Service Desk. We are available 24/7. `n `nThanks, and kind regards,`n `nTechnology Service Desk`n"
    
    <#
.SYNOPSIS

Asks for a username and desired password, then changes the user's password, sets ChangePasswordAtLogon to true, and enables account. Also provides an email to send to the user's line manager.

.DESCRIPTION

Name inspired by the much better system in Nix systems. 
Does what you'd expect a simple password changer to do. 
Changes passwords and enables user.
Do not use if you do not wish to enable the user.
Also displays some pertinent info from get-aduser
#>
}
