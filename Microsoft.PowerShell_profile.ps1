#==============================================================================
# Profile for: <Type of Account>
# 
# Version: 1.0
# Modified: 07/12/2020
# Author: James D. Britton.
#==============================================================================


#==============================================================================
# Prep tasks:
#==============================================================================

# The name of the shell is changed to reflect the type of account
# E.G., it's not uncommon to have a desktop engineer account, std account
# and an AD administrator account, all separate.

    $host.ui.RawUI.WindowTitle = "Type-of-account Shell"

    Set-Location C:\

    Get-Date

    Write-Host "Active interfaces:" -ForegroundColor Cyan
    Get-NetAdapter -Physical |Where-Object status -eq 'up'|Select-Object Name| `
    Write-Host -ForegroundColor Magenta

    Get-NetIPAddress | Where-Object -FilterScript { $_.IPAddress -notlike "169.254*"`
     -and $_.IPAddress -notlike "fe80*" -and $_.IPAddress -notlike "127.0.0.1"`
     -and $_.AddressFamily -notlike "IPv6"} |Select-Object InterfaceAlias,IPAddress



#==============================================================================
# Import Standard Modules:
#==============================================================================


Import-Module ActiveDirectory
#Import-Module BitsTransfer
#Import-Module DnsClient
#Import-Module DHCPServer
#Import-Module GroupPolicy
#Import-Module WindowsSearch




#==============================================================================
# Import Custom Modules:
# Prefer to use imported modules where possible.
# Prefer to use absolute paths where possible - accommodates shared modules
# across multiple different Powershell profiles/accounts.
#==============================================================================


<# PROMPT #>
Import-Module CustomPrompt

<# PASSWORD CHANGER #>
Import-Module Passwd

<# PASSWORD GENERATOR #>
Import-Module C:\Users\james\Documents\Coding\Powershell\PS_Profile_Modules\PSModules\Modules\Passgen

<# PRIMITIVE FILESEARCH #>
Import-Module Filesearch

<# PING THAT GETS LOGGED ON USER #>
Import-Module AdvancedPing

<# OPEN POWERSHELL AS ADMIN #>
Import-Module Elevate

<# GET DISKSPACE #>
#The below is not my script, see the remarks.
Import-Module Get-DiskFree

<# WINDOW TITLE CHANGER #>
Import-Module Set-WindowTitle

<# ONE LINERS AND ALIASES #>
Import-Module Aliases




#==============================================================================
# Effective end of profile: 
# Only templates to go below
#==============================================================================

<# TEMPLATES #>

<#Function Template
function passgen
{
    STUFF

<#
.SYNOPSIS

Synposis goes here.

.DESCRIPTION

Description goes here.

#>
#}
#>