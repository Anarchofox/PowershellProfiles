function AdvPing {
    param ([Parameter(Mandatory = $true, ValueFromPipeline = $true)] [string] $hostVar)

    if ((Test-NetConnection $hostVar).PingSucceeded -eq $True) {
        Write-Output "Successful ping to $hostVar"
    } 
    else {
        Write-Error "Failed to reach $hostVar - double check hostname, or else the device may be offline or otherwise unreachable"
        return $false
        break
    }

    Get-ADComputer $hostVar -Properties Description, OperatingSystem, LastLogonDate, IPv4Address
    Write-Host "Logged on user/System class:"
    Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName $hostVar | Select-Object UserName, __CLASS;

    $loggedInUser = Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName $hostVar; $loggedInUser = Get-ADUser $loggedInUser.UserName.Replace("HEAD_OFFICE\", "") -Properties DisplayName, OfficePhone, ExtensionAttribute15, Manager
    $loggedInUserName = $loggedInUser.DisplayName
    $loggedInUserPhone = $loggedInUser.OfficePhone
    $loggedInUserLoc = $loggedInUser.ExtensionAttribute15
    $loggedInUserSID = $loggedInUser.SID.Value
    try {
        $loggedInUserManager = ((((($loggedInUser.Manager).split("=")[1]).split(",")[0]) | Get-ADUser -Properties * -ErrorAction SilentlyContinue).DisplayName)
    }
    catch { Write-Warning "Some error happened trying to get manager. Check alternative format." }
    finally { $loggedInUserManager = ((((($loggedInUser.Manager).split("=")[1]).split(",")[0]) | Get-ADUser -Properties * -ErrorAction SilentlyContinue).DisplayName) }

    Write-Host "=-----------------------------------------------------="
    Write-Host "• Name: $loggedInUserName"  -ForegroundColor "Green" -BackgroundColor "Black"
    Write-Host "• Phone number: $loggedInUserPhone" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "• Location: $loggedInUserLoc" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "• Hostname: $hostVar" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "User SID: $loggedInUserSID" -ForegroundColor "Yellow" -BackgroundColor "Black"
    Write-Host "User Manager: $loggedInUserManager" -ForegroundColor "Red" -BackgroundColor "Black"
    Write-Host "(Alt. format) Manager:" -NoNewLine; Get-ADUser $loggedInUser -Properties * | Select-Object -ExpandProperty Manager
    Write-Host "=-----------------------------------------------------="

<#
.SYNOPSIS

This is a ping that is slightly more informative. Runs ping, runs get-adcomputer, 
and attempts to determine logged on users and class.

.DESCRIPTION

Runs simple commands in succession. Intended to gather a bit more 
information about a computer that responds to a ping.
Leverages Get-WMIObject to determine computer class and signed in user.
TODO: The try/catch block causes an issue in some environments, it always fails over to the catch block
when it shouldn't.

#>
}
