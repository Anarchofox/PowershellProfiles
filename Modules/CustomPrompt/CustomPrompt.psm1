#==============================================================================
# Custom prompt for Powershell -- shows window title, location, time,
# and current user. 
# Can be easily changed to use random colours. 
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

function prompt
{
    Write-Host ""
    Write-Host ("" + "Current Focus: ["+$($host.UI.RawUI.WindowTitle +"]")) -ForegroundColor Cyan -BackgroundColor Magenta
    Write-Host ("" + "Current Loc.: ["+$(Get-Location) +"]")`
    -ForegroundColor Magenta
    Write-Host "Current time: [$(Get-Date)]" -ForegroundColor Cyan
    write-host "Current user: [$env:USERNAME]" -ForegroundColor Magenta
        return " > `$  "
}