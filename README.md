# Introduction
Hi, I hope you find this script useful!

This script can:
1. Connect to a remote server.
2. Connect to a PostgreSQL Server & export the preferred schema.
4. Download the exported [schema].[DATE].sql to your computer.
5. Delete the [schema] from your local PostgreSQL Server.
6. Import the freshly downloaded [schema].[DATE].sql file to that schema.

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
