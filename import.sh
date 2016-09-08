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

source $PROJECTPATH/lib/common.tcl
source $PROJECTPATH/lib/init.tcl

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

source $PROJECTPATH/lib/shutdown.tcl
