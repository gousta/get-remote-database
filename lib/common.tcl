# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

proc clr {foreground text} {
  return [exec tput setaf $foreground]$text[exec tput sgr0]
}