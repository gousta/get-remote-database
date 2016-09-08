# Introduction
I believe that if there is a command you have to run more than once a month,
it is worth automating.

The same commands I used to run to be able to ssh to a server, export a db's data,
download it and then import it on my computer have been bundled up on a set of scripts
that do exactly what their names are.

Generally, a full list of commands would be:
1. SSH to remote server
2. Connect to a PostgreSQL Server & export the preferred schema
3. Download the exported [SCHEMA].[DATE].sql to your computer
4. Drop the [SCHEMA] from your local PostgreSQL Server
5. Import the freshly downloaded [SCHEMA].[DATE].sql file to that schema

**NOTE:** Not all scripts do the above. Sometimes I just need to download once a day,
keep destroying a db and then import again and again to restore it.

-

### Usage:
Please use `configuration/example.conf.tcl` as your starting configuration file.

From within the project, copy `configuration/example.conf.tcl` to `{my-key}.conf.tcl`:
```
cp configuration/example.conf.tcl configuration/{my-key}.conf.tcl
```
**Edit `{my-key}.conf.tcl` to match your environment settings.**

-

The scripts should have execute permissions in order to be executable:
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
rpgup {my-key}
```

That's it. Feel free to contribute if you'd like or feel like something can be improved.

### Made with <3 in Athens, Greece
