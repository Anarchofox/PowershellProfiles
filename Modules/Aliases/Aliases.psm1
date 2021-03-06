#==============================================================================
# This module contains all one-liner functions and aliases
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================


function edit ($file) { & "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe" $file }
function explore { "explorer.exe `"$(pwd)`"" | iex }
function touch ($file) { echo "" >> $file; }
function wget ($url) {(new-object Net.WebClient).DownloadString("$url")}
function HKLM:  { Set-Location HKLM: }
function HKCU:  { Set-Location HKCU: }
function Env:   { Set-Location Env: }
function Softrepo:   { Set-Location "\\dhw.wa.gov.au\appdata\PackageSource\Library\Applications" }

Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin
Set-Alias -Name grep -Value select-string
Set-Alias -Name df -Value get-diskfree