# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO MYSQL USING MYSQLDUMP
# ------------------------------------------------------------------------------

set MSG "\nReplacing $LCDBSCHEMA schema with newly downloaded file"
puts "[clr 6 $MSG]"

spawn sh -c "mysqldump -f --opt --protocol=TCP --user=$LCDBUSER --password=$LCDBPASSWORD $LCDBNAME < $DOWNLOAD_FOLDER/$FILE"
interact
