#==============================================================================
# Custom prompt for Powershell -- shows window title, location, time,
# and current user. 
# Can be easily changed to use random colours. 
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

function prompt{
    $hostname = hostname
    Write-Host ("░▒▒▓") -NoNewline -ForegroundColor Magenta
    Write-Host ("" + " ["+$($host.UI.RawUI.WindowTitle +"]")) -ForegroundColor Cyan -BackgroundColor Magenta -NoNewline
    Write-Host ("▓▒▒░") -ForegroundColor Magenta
    Write-Host ("" + " ["+$(Get-Location) +"]").Replace("Microsoft.PowerShell.Core\FileSystem::","[Remote::]") -ForegroundColor Magenta
    Write-Host " [$(Get-Date)]" -ForegroundColor Cyan -NoNewLine
    Write-Host " ~" -ForegroundColor White -NoNewLine
    Write-Host " [$env:USERNAME@$hostname]" -ForegroundColor Magenta
        return " ->> "
}
