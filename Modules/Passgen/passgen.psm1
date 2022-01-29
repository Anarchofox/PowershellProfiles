#==============================================================================
# Password generator that works with a word-list to generate simple, readable
# but sufficiently entropic passwords for users who don't want to type random
# jumbles of symbols. Prints 6 possible options to the console.
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

<# PASSWORD GENERATOR #>
function passgen
{

    Write-Host "----------------------------------" -ForegroundColor Magenta
    
    (1..6) | 
    ForEach-Object {
       $WordList = "C:\Temp\wordList.txt" #Here we define the file from which we will source our three words

        $P1 = Get-Content $WordList |Get-Random
        $P2 = Get-Content $WordList |Get-Random
        #$P3 = Get-Content $WordList |Get-Random
        $P4 = Get-Random -Minimum 100 -Maximum 999
        $P5 = Get-Random '!','@','#','$','%','^','&'
        #$P6 = "$P1$P2$P3$P4$P5"
        $P6 = "$P1$P2$P4$P5"
    
        Write-Host "Password is: $P6" -ForegroundColor Green
       
        }
    Write-Host "----------------------------------" -ForegroundColor Magenta

<#
.SYNOPSIS

Extremely lazy password generator that relies on the presence of a word-list.

.DESCRIPTION

Generates a password out of 6 steps. Gets 3 random words from a word-list. Then a random 3 digit string. Then a random special character.
Then mashes it all together and produces a long, secure password. Provides six such passwords for you.

#>
}
