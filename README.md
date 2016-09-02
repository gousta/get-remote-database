# Introduction
This Tcl script connects, exports, downloads and imports from remote to local PostgreSQL server.

###### Steps
1. SSH to remote server
2. Connect to a PostgreSQL Server & export the preferred schema
3. Download the exported [SCHEMA].[DATE].sql to your computer
4. Drop the [SCHEMA] from your local PostgreSQL Server
5. Import the freshly downloaded [SCHEMA].[DATE].sql file to that schema


### How to use
Please use `configuration/example.conf.tcl` as your starting configuration file.

From within the project, copy `configuration/example.conf.tcl` to `{my-key}.conf.tcl`:
```
cp configuration/example.conf.tcl configuration/{my-key}.conf.tcl
```
Edit `{my-key}.conf.tcl` to match your environment settings.

The script should have execute permissions in order to be executable:
```
chmod u+x run.sh
```
Then simply run it by calling:
```
./run.sh {my-key}
```

OR you can create an alias to it:
```
alias rpgup="/PATH/TO/PROJECT/get-remote-pg-database/run.sh"
```
And then use it like this:
```
rpgup {}
```

That's it. Feel free to contribute if you'd like or feel like something can be improved.

### Made with <3 in Athens, Greece
