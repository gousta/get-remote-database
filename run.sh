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

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

proc clr {foreground text} {
  return [exec tput setaf $foreground]$text[exec tput sgr0]
}

# ------------------------------------------------------------------------------
# SET VARIABLES
# ------------------------------------------------------------------------------

set TODAY [timestamp -format %d.%m.%Y]
set DATESTAMP [timestamp -format %d%m%Y]
set CONFIGFILE $argv

# ------------------------------------------------------------------------------
# SHOW WELCOME
# ------------------------------------------------------------------------------

puts "--------------------------------------------------------------------------"
puts "--                    GET REMOTE POSTGRESQL DATABASE                    --"
puts "--------------------------------------------------------------------------"
puts " "

# ------------------------------------------------------------------------------
# LOAD CONFIGURATION FILE
# ------------------------------------------------------------------------------

if {$CONFIGFILE == ""} {
  set MSG "Expecting configuration key after script name."
  puts "[clr 1 $MSG]"
  exit 0
}

set CONFIGPATH "configuration/$CONFIGFILE.conf.tcl"

if {[file exists $CONFIGPATH] == 1} {
  set MSG "Configuration Loaded: $CONFIGPATH"
  puts "[clr 6 $MSG]"
  source $CONFIGPATH
} else {
  set MSG "Failed to read configuration file: $env(PWD)/$CONFIGPATH"
  puts "[clr 1 $MSG]"
  exit 0
}

# ------------------------------------------------------------------------------
# SCRIPT STARTS HERE
# ------------------------------------------------------------------------------

set DOWNLOAD_FOLDER "$env(PWD)/downloads"
set FILE "$PGDBNAME.$PGSCHEMA.$DATESTAMP.sql"
set PGPWD "PGPASSWORD=\"$PGPASSWORD\""

set MSG "File: $FILE"
puts "[clr 6 $MSG]"

set MSG "Cleaning downloads folder..."
puts "[clr 3 $MSG]"
file delete -force $DOWNLOAD_FOLDER
file mkdir $DOWNLOAD_FOLDER

# ------------------------------------------------------------------------------
# SSH TO SERVER
# ------------------------------------------------------------------------------

set MSG "\nConnecting to remote server..."
puts "[clr 6 $MSG]"

eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no $SERVERSSH

set SSHPROMPT ":|#|\\\$"

interact -o -nobuffer -re $SSHPROMPT return
send "$SERVERPWD\r"

# ------------------------------------------------------------------------------
# RUN PG_DUMP AND SAVE TO $FILE
# ------------------------------------------------------------------------------

set MSG "\nExporting $PGSCHEMA schema to SQL file..."
puts "[clr 6 $MSG]"

interact -o -nobuffer -re $SSHPROMPT return
send "$PGPWD pg_dump -h $PGHOST -U $PGUSER -n $PGSCHEMA -v $PGDBNAME > $FILE\r"

send "exit\r"
interact

# ------------------------------------------------------------------------------
# DOWNLOAD FILE FROM SERVER USING SCP
# ------------------------------------------------------------------------------

set MSG "\nDownloading exported database from remote server"
puts "[clr 6 $MSG]"

spawn scp "$SERVERSSH:$EXPORT_FOLDER$FILE" $DOWNLOAD_FOLDER

expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
  -re ".*sword.*" {
    exp_send "$SERVERPWD\r"
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
send "\\i $DOWNLOAD_FOLDER/$FILE \r"
send "\\q\r"
interact

# ------------------------------------------------------------------------------
# TODO: CLEAN FILES FROM REMOTE SERVER AND LOCAL DESKTOP
# SHOW MESSAGES
# ------------------------------------------------------------------------------

set MSG "\n\nScript has finished successfully"
puts "[clr 2 $MSG]"

puts "--------------------------------"
puts "     Made with ❤  in [clr 1 A][clr 6 t][clr 3 h][clr 2 e][clr 5 n][clr 6 s]"
puts "--------------------------------"

# ------------------------------------------------------------------------------
exit 0
