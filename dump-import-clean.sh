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

source $PROJECTPATH/lib/import_clean.tcl
source $PROJECTPATH/lib/shutdown.tcl
