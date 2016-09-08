#!/usr/bin/expect -f
# ------------------------------------------------------------------------------
# Author: Stratos Giouldasis <giouldasis.stratos@gmail.com>
#
# Made with ❤ in Athens, Greece
#
# Configuration: Make sure config.tcl exists and contains all necessary
# variables. Defaults can be found in config.example.tcl
# ------------------------------------------------------------------------------
global env

set SCRIPTPATH [ dict get [ info frame 0 ] file ]
set PROJECTPATH [file dirname $SCRIPTPATH]

source $PROJECTPATH/shared.tcl

# ------------------------------------------------------------------------------
# LOAD CONFIGURATION FILE
# ------------------------------------------------------------------------------

if {$CONFIGFILENAME == ""} {
  set MSG "Configuration parameter is missing.\nCorrect usage: rpgup {config}"
  puts "[clr 1 $MSG]"
  exit 0
}

if {[file exists $CONFIGPATH] == 1} {
  set MSG "Configuration Loaded: $CONFIGPATH"
  puts "[clr 6 $MSG]"
  source $CONFIGPATH
} else {
  set MSG "Failed to read configuration file: $CONFIGPATH"
  puts "[clr 1 $MSG]"
  exit 0
}

# ------------------------------------------------------------------------------
# SCRIPT STARTS HERE
# ------------------------------------------------------------------------------

set FILE "$PGDBNAME.$PGSCHEMA.$DATESTAMP.sql"
set PGPWD "PGPASSWORD=\"$PGPASSWORD\""

set MSG "File: $FILE"
puts "[clr 6 $MSG]"

set MSG "Cleaning downloads folder..."
puts "[clr 3 $MSG]"
puts "[clr 3 $DOWNLOAD_FOLDER]"
file delete -force $DOWNLOAD_FOLDER
file mkdir $DOWNLOAD_FOLDER

# ------------------------------------------------------------------------------
# RUN PG_DUMP AND SAVE TO $FILE
# ------------------------------------------------------------------------------

set MSG "\nExporting $PGSCHEMA schema to SQL file..."
puts "[clr 6 $MSG]"

spawn pg_dump --no-owner --no-acl --data-only -h $PGHOST -U $PGUSER -n $PGSCHEMA -v $PGDBNAME -f $DOWNLOAD_FOLDER/$FILE
if {$PGPASSWORD != ""} {
  expect {
    -re ".*es.*o.*" {
      exp_send "yes\r"..,.
      exp_continue
    }
    -re ".*sword.*" {
      exp_send "$PGPASSWORD\r"
    }
  }
}
interact

# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO POSTGRESQL USING PSQL
# ------------------------------------------------------------------------------

set MSG "\nReplacing $LCPGSCHEMA schema with newly downloaded file"
puts "[clr 6 $MSG]"

spawn psql -U $LCPGUSER -d $LCPGDBNAME
send "DROP SCHEMA IF EXISTS $LCPGSCHEMA CASCADE;\r"
send "CREATE SCHEMA IF NOT EXISTS $LCPGSCHEMA;\r"
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "\\q\r"
interact

# ------------------------------------------------------------------------------
# TODO: CLEAN FILES FROM REMOTE SERVER AND LOCAL DESKTOP
# SHOW MESSAGES
# ------------------------------------------------------------------------------

set MSG "\n\nScript has finished successfully"
puts "[clr 2 $MSG]"
puts "Made with ❤ in [clr 1 A][clr 6 t][clr 3 h][clr 2 e][clr 5 n][clr 6 s]"

# ------------------------------------------------------------------------------
exit 0
