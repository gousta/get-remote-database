# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO POSTGRESQL USING PSQL
# ------------------------------------------------------------------------------

set MSG "\nReplacing $LCPGSCHEMA schema with newly downloaded file"
puts "[clr 6 $MSG]"

spawn psql -U $LCPGUSER -d $LCPGDBNAME
send "DROP SCHEMA IF EXISTS $LCPGSCHEMA CASCADE;\r"
send "CREATE SCHEMA IF NOT EXISTS $LCPGSCHEMA;\r"
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "$COMMANDS\r"
send "\\q\r"
interact