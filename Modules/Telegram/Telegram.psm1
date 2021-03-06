#==============================================================================
# Quick way to send a MSG.EXE to a computer/user
# Basically just saves on the tedium of having to type/remember the syntax for
# the MSG command when you're trying to send a quick thing.
#
# Modified: 07/12/2020
# Version: 1.0
# Author: James Britton
#==============================================================================

<# Telegram! MSG.EXE is the best! #>

function Telegram
{
    $RECIPIENT = Read-Host "Who is the target user? * For any and all"
    $RECIPIENTCOMPUTER = Read-Host "Enter the server name or IP address, blank for local system"
    $MESSAGE = Read-Host "Message for target"
    msg $RECIPIENT /Server:$RECIPIENTCOMPUTER $MESSAGE
<#
.SYNOPSIS

Asks for the user, server, and message content, then sends it using MSG.EXE

.DESCRIPTION

Asks for the user, server, and message content, then sends it using MSG.EXE
#>
}