# dumpSeparator
Allows to extract a single database from a collective dump or purge the full dump from a single database.

Huge mysql dump that contains many databases are not manageable from any text editor (Joe https://joe-editor.sourceforge.io/  is one of the few).
This bash script uses sed to quickly edit those files.

**Warning**
This script has not been extensively tested and it is supposed to work for moderate size dump (>10Gb).

## Extract example
To extract a single database dump:

    ./dumpSeparator.sh extract myDatabase myDump.sql

This command will create a backup file and a new file with only the myDatabase dump.

## Purge example 
To purge a huge database dump from a single not useful database:

    ./dumpSeparator.sh purge myDatabase myDump.sql

This command will create a backup file and a new file without the myDatabase dump.
