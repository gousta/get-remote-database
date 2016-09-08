#!/usr/bin/expect -f
# ------------------------------------------------------------------------------
# Author: Stratos Giouldasis <giouldasis.stratos@gmail.com>
#
# Made with ❤ in Athens, Greece
#
# Configuration: Make sure config.tcl exists and contains all necessary
# variables. Defaults can be found in config.example.tcl
# ------------------------------------------------------------------------------
set SCRIPTPATH [ dict get [ info frame 0 ] file ]
set PROJECTPATH [file dirname $SCRIPTPATH]

source $PROJECTPATH/lib/common.tcl
source $PROJECTPATH/lib/init.tcl

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
send "$PGPWD pg_dump --no-owner --no-acl -h $PGHOST -U $PGUSER -n $PGSCHEMA -v $PGDBNAME > $FILE\r"

send "exit\r"
interact

# ------------------------------------------------------------------------------
# DOWNLOAD FILE FROM SERVER USING SCP
# ------------------------------------------------------------------------------

set MSG "\nDownloading exported database from remote server"
puts "[clr 6 $MSG]"

spawn scp "$SERVERSSH:$EXPORT_FOLDER$FILE" $DOWNLOAD_FOLDER/$FILE

if {$SERVERPWD != ""} {
  expect {
    -re ".*es.*o.*" {
      exp_send "yes\r"..,.
      exp_continue
    }
    -re ".*sword.*" {
      exp_send "$SERVERPWD\r"
    }
  }
}
interact

source $PROJECTPATH/lib/import_clean.tcl
source $PROJECTPATH/lib/shutdown.tcl