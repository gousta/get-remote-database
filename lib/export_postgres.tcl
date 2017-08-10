# ------------------------------------------------------------------------------
# DUMP DATABASE TO $FILE
# ------------------------------------------------------------------------------

set PGPWD "PGPASSWORD=\"$DBPASSWORD\""

set MSG "\nExporting"
puts "[clr 6 $MSG]"

interact -o -nobuffer -re $SSHPROMPT return
send "$PGPWD pg_dump --no-owner --no-acl -h $DBHOST -U $DBUSER -n $DBSCHEMA -v $DBNAME > $EXPORT_FOLDER$FILE\r"

send "exit\r"
interact