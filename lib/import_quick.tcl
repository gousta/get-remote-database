# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO POSTGRESQL USING PSQL
# ------------------------------------------------------------------------------

set MSG "\nReplacing $LCDBSCHEMA schema with newly downloaded file"
puts "[clr 6 $MSG]"

spawn psql -U $LCDBUSER -d $LCDBNAME
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "$COMMANDS\r"
send "\\q\r"
interact