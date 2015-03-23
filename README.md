# Introduction
This Tcl script connects, exports, downloads and imports from remote to local PostgreSQL server.

###### Procedure
1. Connect to a remote server
2. Connect to a PostgreSQL Server & export the preferred schema
3. Download the exported [schema].[DATE].sql to your computer
4. Delete the [schema] from your local PostgreSQL Server
5. Import the freshly downloaded [schema].[DATE].sql file to that schema


### How to use
The script should have execute permissions in order to be executable:
```
chmod u+x getjets.sh
```
Then simply run it by calling:
```
./getjets.sh
```

### Made with ❤ in Athens, Greece
