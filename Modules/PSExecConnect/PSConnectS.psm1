#==============================================================================
# Leverages PSEXEC to open a Powershell on a remote host with System privilege
# 
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================


function PSConnectS
{
    $TARGETCOMPUTER = Read-Host "Enter the server name or IP address"
    Set-Location C:\Temp\SysInternals\
	Write-Host ".\PsExec.exe \\$TARGETCOMPUTER -s powershell"
	.\PsExec.exe \\$TARGETCOMPUTER -s powershell
<#
.SYNOPSIS

Connects to a computer via PSEXEC and Powershell authenticating as the local SYSTEM Authority.

.DESCRIPTION

Connects to a computer via PSEXEC and Powershell authenticating as the local SYSTEM Authority.
#>
}