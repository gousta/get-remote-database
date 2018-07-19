# ------------------------------------------------------------------------------
# SET VARIABLES
# ------------------------------------------------------------------------------

set DATESTAMP [timestamp -format %d%m%Y]
set CONFIGFILENAME $argv

set CONFIGPATH "$PROJECTPATH/configuration/$CONFIGFILENAME.conf.tcl"

# ------------------------------------------------------------------------------
# LOAD CONFIGURATION FILE
# ------------------------------------------------------------------------------
if {$CONFIGFILENAME == ""} {
  set MSG "Configuration parameter is missing.\nCorrect usage: grd {config}"
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
# SET SOME MORE VARIABLES
# ------------------------------------------------------------------------------

set FILE "$CONFIGFILENAME.$DBNAME.sql"

set MSG "File: $FILE"
puts "[clr 6 $MSG]"