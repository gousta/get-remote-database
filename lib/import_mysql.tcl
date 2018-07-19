# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO MYSQL USING MYSQLDUMP
# ------------------------------------------------------------------------------

set MSG "\nImporting"
puts "[clr 6 $MSG]"

spawn sh -c "mysql --user=$LCDBUSER --password=$LCDBPASSWORD $LCDBNAME < /tmp/$FILE"
interact
