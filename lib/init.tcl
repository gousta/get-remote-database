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

# set MSG "Cleaning downloads folder..."
# puts "[clr 3 $MSG]"
# puts "[clr 3 $DOWNLOAD_FOLDER]"
# file delete -force $DOWNLOAD_FOLDER
# file mkdir $DOWNLOAD_FOLDER