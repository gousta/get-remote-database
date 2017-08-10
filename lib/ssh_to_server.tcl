# ------------------------------------------------------------------------------
# SSH TO SERVER
# ------------------------------------------------------------------------------

set MSG "\nConnecting..."
puts "[clr 6 $MSG]"

eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no $SERVERSSH

set SSHPROMPT ":|#|\\\$"

interact -o -nobuffer -re $SSHPROMPT return
send "$SERVERPWD\r"