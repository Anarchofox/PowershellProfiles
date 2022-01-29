#==============================================================================
# Quickly checks if someone is a member of an AD group, and if they aren't
#  then adds them.
#
# Modified: 09/04/2021
# Version: 1.0
# Author: James Britton
#==============================================================================

function Add-ToGroup {
  param
  ([Parameter(Mandatory, HelpMessage = "Enter the user's SAM account name.")]
    $User,
    [Parameter(Mandatory, HelpMessage = "Enter the group's full name.")]
    $Group)

  if (((Get-ADGroup -filter { name -like $Group } | Select-Object -First 1) | Get-ADGroup)) {
    Write-Host "$Group exists."
    if ((Get-ADPrincipalGroupMembership -Identity $user | Select-Object -ExpandProperty Name) -ilike "$Group") {
      Write-Host "User is already a member of $Group." -ForegroundColor Red -BackgroundColor Black
    } 
    else {
      $Group = ((Get-ADGroup -filter { name -like $Group } | Select-Object -First 1) | Get-ADGroup)
      Write-Host "User is not member of $Group. Adding to Group" -ForegroundColor Black -BackgroundColor Green
      $ErrorActionPreference = 'Stop'
      try {
        Add-ADPrincipalGroupMembership -Identity $user -MemberOf $Group -Verbose 
      }
      catch {
        Write-Host "Exception: $($_.Exception.Message)"
        Write-Host "Halting. Check on the above error."
      }
    }
  }
  else {
    Write-Host "Unable to find $Group" -ForegroundColor Black -BackgroundColor Red
    throw "Unable to find the specified group."
  }
        


  <#
.SYNOPSIS

Quickly checks if someone is a member of an AD group, and if they aren't, then it adds them.

.DESCRIPTION

Quickly checks if someone is a member of an AD group, and if they aren't, then it adds them. 
We're not talking anything highly advanced here, it's just because: if you can do a thing
with the keyboard and powershell instead of clicking around like a pleb, then do it.

#>
}