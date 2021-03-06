#==============================================================================
# Changes the Window Title. Because remembering to type this garbage is for 
# plebs. Very simple.
# 
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================


function Set-WindowTitle
{
    # If the arguments are empty, this will exit the script.
        if ($args.count -lt 1) 
            {
                Write-host "Empty arguments. Acceptable format is: Set-WindowTitle <desired title>" -ForegroundColor Red;
                Break
            }

    $host.UI.RawUI.WindowTitle = $args[0]

    Write-Host "Window Title Changer" -ForegroundColor Magenta
    Write-Host "==================================================================" -ForegroundColor Magenta
    Write-Host "Title of window set to:" -ForegroundColor Red
    Write-Output $host.UI.RawUI.WindowTitle
    Write-Host "==================================================================" -ForegroundColor Magenta

<#
.SYNOPSIS

Changes window title.

.DESCRIPTION

Modifies $host.UI.RawUI.WindowTitle to specified argument.

#>
#}
}