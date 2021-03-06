#==============================================================================
# Quick and dirty file search that you should never use.
# Useful only when other options aren't available. Seriously, this is slow.
# Also, by design it searches the location you're in, and doesn't recurse.
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================


function filesearch
{
    $searchVar = Read-Host 'Search for what';
    Get-ChildItem | Where-Object name -like "*$searchVar*" | sort-object LastWriteTime -Descending
    Get-ChildItem | Where-Object name -like "*$searchVar*" | sort-object LastWriteTime -Descending |Measure-Object |Select-Object count

<#
.SYNOPSIS

Asks for a string to search in a location. Intended use: locating logfiles, 
but can be used to find and child-item that maches a string.

.DESCRIPTION

Searches for any file that contains a string in its name, then displays it sorted by last write time, 
then counts the number of results.

#>
}