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
set CONFIGFILENAME $argv

set CONFIGPATH "$PROJECTPATH/configuration/$CONFIGFILENAME.conf.tcl"
set DOWNLOAD_FOLDER "$PROJECTPATH/downloads"