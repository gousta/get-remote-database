#!/usr/bin/expect -f
# ------------------------------------------------------------------------------
# Author: Stratos Giouldasis <giouldasis.stratos@gmail.com>
#
# Made with ❤ in Athens, Greece
#
# Configuration: Make sure config.tcl exists and contains all necessary
# variables. Defaults can be found at config.example.tcl
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

proc clr {foreground text} {
  return [exec tput setaf $foreground]$text[exec tput sgr0]
}

# ------------------------------------------------------------------------------
# SET DATE VARIABLES
# ------------------------------------------------------------------------------
set TODAY [timestamp -format %d.%m.%Y]
set DATESTAMP [timestamp -format %d%m%Y]

# ------------------------------------------------------------------------------
# LOAD CONFIGURATION FILE
# ------------------------------------------------------------------------------
set CONFIGFILE "config.tcl"

if {[file exists $CONFIGFILE] == 1} {
  set MSG "Configuration: Loaded."
  puts "[clr 6 $MSG]"
  source $CONFIGFILE
} else {
  set MSG "Failed to read configuration file: $env(PWD)/$CONFIGFILE"
  puts "[clr 1 $MSG]"
}

# ------------------------------------------------------------------------------
# SCRIPT STARTS HERE
# ------------------------------------------------------------------------------
set DOWNLOAD_FOLDER "$env(PWD)/downloads"
set FILE "$PGDBNAME.$PGSCHEMA.$DATESTAMP.sql"
set PGPWD "PGPASSWORD=\"$PGPASSWORD\""


set MSG "Today is: $TODAY."
puts "[clr 6 $MSG]"
set MSG "File: $FILE"
puts "[clr 6 $MSG]"

# ------------------------------------------------------------------------------
# DROP PREVIOUS & IMPORT DOWNLOADED FILE TO POSTGRESQL USING PSQL
# ------------------------------------------------------------------------------

set MSG "\nReplacing $LCPGSCHEMA schema with newly downloaded file"
puts "[clr 6 $MSG]"

spawn psql -U $LCPGUSER -d $LCPGDBNAME
send "DROP SCHEMA IF EXISTS $LCPGSCHEMA CASCADE;\r"
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "\\q\r"
interact

# ------------------------------------------------------------------------------
# TODO: CLEAN FILES FROM REMOTE SERVER AND LOCAL DESKTOP
# SHOW MESSAGES
# ------------------------------------------------------------------------------

set MSG "\nScript has finished successfully"
puts "[clr 2 $MSG]"

puts "--------------------------"
puts "  Made with ❤  in [clr 1 A][clr 6 t][clr 3 h][clr 2 e][clr 5 n][clr 6 s]"
puts "--------------------------"

# ------------------------------------------------------------------------------
exit 0
