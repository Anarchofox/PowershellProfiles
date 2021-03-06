function AdvPing($hostVar)
{
    #$hostVar = Read-Host 'Hostname (IP does not work properly)';
    ping -n 3 $hostVar
    Get-ADComputer $hostVar -Properties Description,OperatingSystem,LastLogonDate,IPv4Address
    Write-Host "Logged on user/System class:"
    Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName $hostVar| Select-Object UserName,__CLASS;

    $loggedInUser = Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName $hostVar; $loggedInUser = Get-ADUser $loggedInUser.UserName.Replace("HEAD_OFFICE\","") -Properties DisplayName,OfficePhone,ExtensionAttribute15,Manager
    $loggedInUserName = $loggedInUser.DisplayName
    $loggedInUserPhone = $loggedInUser.OfficePhone
    $loggedInUserLoc = $loggedInUser.ExtensionAttribute15
    $loggedInUserSID = $loggedInUser.SID.Value
    $loggedInUserManager = ((((($loggedInUser.Manager).split("=")[1]).split(",")[0]) | Get-ADUser -Properties *).DisplayName)

    Write-Host "=-----------------------------------------------------="
    Write-Host "Real name: $loggedInUserName"  -ForegroundColor "Green" -BackgroundColor "Black"
    Write-Host "Phone number: $loggedInUserPhone" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "Location: $loggedInUserLoc" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "User SID: $loggedInUserSID" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "User Manager: $loggedInUserManager" -ForegroundColor "Red" -BackgroundColor "Black"
    Write-Host "=-----------------------------------------------------="
<#
.SYNOPSIS

This is a ping that is slightly more informative. Runs ping, runs get-adcomputer, 
and attempts to determine logged on users and class.

.DESCRIPTION

Runs simple commands in succession. Intended to gather a bit more 
information about a computer that responds to a ping.
Leverages Get-WMIObject to determine computer class and signed in user.

#>
}
