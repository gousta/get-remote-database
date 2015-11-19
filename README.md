# Introduction
This Tcl script connects, exports, downloads and imports from remote to local PostgreSQL server.

###### Steps
1. Connect to a remote server
2. Connect to a PostgreSQL Server & export the preferred schema
3. Download the exported [schema].[DATE].sql to your computer
4. Delete the [schema] from your local PostgreSQL Server
5. Import the freshly downloaded [schema].[DATE].sql file to that schema


### How to use
Use `configuration/config.example.tcl` as sample configuration file.
Copy `configuration/config.example.tcl` to `<my-key>.conf.tcl`:
```
cp configuration/config.example.tcl configuration/<my-key>.conf.tcl
```
Edit `<my-key>.conf.tcl` to match your environment settings.

The script should have execute permissions in order to be executable:
```
chmod u+x run.sh
```
Then simply run it by calling:
```
./run.sh <my-key>
```

### Made with <3 in Athens, Greece
