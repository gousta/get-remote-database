# Configuration
# Please make sure that all values are set properly.

## Remote filesystem path to save extracted SQL (put a slash in the end)
set EXPORT_FOLDER "/path/to/folder/"

## Server Settings (leave ssh password blank if you connect using an SSH key)
set SERVERSSH "<username>@<host.com>"
set SERVERPEM ""
set SERVERPWD ""

## Remote PostgreSQL Settings
set PGHOST "<IP>"
set PGDBNAME "<database_name>"
set PGSCHEMA "<schema>"
set PGUSER ""
set PGPASSWORD ""

## Local PostgreSQL Settings
set LCPGDBNAME "<database_name>"
set LCPGSCHEMA "<schema>"
set LCPGUSER "<your-system-profile-username>"