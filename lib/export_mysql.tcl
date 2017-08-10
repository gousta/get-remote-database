# ------------------------------------------------------------------------------
# DUMP DATABASE TO $FILE
# ------------------------------------------------------------------------------

set MSG "\nExporting"
puts "[clr 6 $MSG]"

interact -o -nobuffer -re $SSHPROMPT return
send "mysqldump --opt --protocol=TCP --host=$DBHOST --user=$DBUSER --password=$DBPASSWORD $DBNAME > $EXPORT_FOLDER$FILE\r"

send "exit\r"
interact