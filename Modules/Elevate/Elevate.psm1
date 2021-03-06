#==============================================================================
# This module contains two different scripts to either switch to an admin
# shell or to launch a process with administrator privileges
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

function elevate
{
    write-host 'Attempting to start Powershell as administrator:' -ForegroundColor Red
    start-process powershell -Verb runas 


<#
.SYNOPSIS

Opens a powershell with administrator privileges. Typically can only be opened by an ED account.

.DESCRIPTION

Leverages the -Verb function to start a powershell with elevated privileges.
This is required for many tasks and may be quicker than going through the GUI User Access Control.

#>
}

function sudo
{
    if ($args.Count -gt 0)
    {   
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
<#
.SYNOPSIS

With no arguments, opens a Powershell as admin. With arguments, tries to open that process with
administrator rights.

.DESCRIPTION

Leverages the -Verb function to start a process with elevated privileges.
This is required for many tasks and may be quicker than going through the GUI User Access Control.

#>
}