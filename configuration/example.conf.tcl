# Configuration
# Please make sure that all values are set properly.

## Remote filesystem path to save extracted SQL (put a slash in the end)
set EXPORT_FOLDER "/path/to/folder/"

## Server Settings (leave ssh password blank if you connect using an SSH key)
set SERVERSSH "<username>@<host.com>"
set SERVERPEM ""
set SERVERPWD ""

set DB "<postgres or mysql>"

## Remote Database Settings
set DBHOST ""
set DBSCHEMA ""
set DBNAME ""
set DBUSER ""
set DBPASSWORD ""

## Local Database Settings
set LCDBSCHEMA ""
set LCDBNAME ""
set LCDBUSER ""
set LCDBPASSWORD ""

## PSQL commands to run locally after import
set COMMANDS ""