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