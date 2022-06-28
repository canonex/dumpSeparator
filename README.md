# DumpSeparator
Allows to extract a single database from a collective dump or purge the full dump from a single database.

![Db tools](db-tools.svg)

Huge mysql dump that contains many databases are not manageable from any text editor (Joe https://joe-editor.sourceforge.io/  is one of the few).
This bash script uses sed to quickly edit those files.

**Warning**
This script has not been extensively tested and it is supposed to work for moderate size dump (<10Gb).

## List example
To list all the databases in a dump:

    ./dumpSeparator.sh list myDump.sql

## Extract example
To extract a single database dump:

    ./dumpSeparator.sh extract myDatabase myDump.sql

This command will create a backup file and a new file with only the myDatabase dump.

## Purge example 
To purge a huge database dump from a single not useful database:

    ./dumpSeparator.sh purge myDatabase myDump.sql

This command will create a backup file and a new file without the myDatabase dump.

## How to create a mysql dump?
You can create a dump using the [mysqldump](https://mariadb.com/kb/en/mariadb-dumpmysqldump/) utility, for MySql and MariaDb.
You want an automatic procedure? Try using [backupMysql](https://github.com/canonex/backupMysql)