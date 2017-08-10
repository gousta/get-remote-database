# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO POSTGRESQL USING PSQL
# ------------------------------------------------------------------------------

set MSG "\nImporting"
puts "[clr 6 $MSG]"

spawn psql -U $LCDBUSER -d $LCDBNAME
send "DROP SCHEMA IF EXISTS $LCDBSCHEMA CASCADE;\r"
send "CREATE SCHEMA IF NOT EXISTS $LCDBSCHEMA;\r"
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "$COMMANDS\r"
send "\\q\r"
interact