#!/bin/bash

#Copyright (c) 2018 Riccardo Gagliarducci <riccardo@brixel.it>
#https://github.com/canonex/dumpSeparator

#This is free software.  You may redistribute copies of it under the terms of the GNU General Public License.
#There is NO WARRANTY, to the extent permitted by law.


#Courtesy of https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash


#Courtesy of https://stackoverflow.com/questions/4332478/read-the-current-text-color-in-a-xterm/4332530#4332530
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
LIME_YELLOW=$(tput setaf 190)
CYAN=$(tput setaf 6)

usage() {
	echo ""
	echo "Usage: $0 list DUMPFILE"
	echo "   or  $0 extract|purge DATABASENAME DUMPFILE"
	echo ""
	echo "DUMPFILE is the sql dump ex. mydump.sql"
	echo "DATABASENAME is the name of the database, use list command to list the available names"
	echo "" 1>&2; exit 1; }



case $1 in

	list)
	
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "List option expects one database name."
			usage
			exit 1
		fi
		
    echo "Listing db ${LIME_YELLOW}$2${NORMAL}:"
    echo "${CYAN}"

		#Listing all db
		grep 'Dumping events' "$2" | sed 's/-- Dumping events for database //' | sed "s/'//g"
		
		echo "${NORMAL}"
    ;;


	extract)
	
		if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
			echo "Extract option expects one database name and one mysql dump file."
			usage
			exit 1
		fi
		
		#Making a backup
		cp "$3" "$3.old"
	
    echo "Extracting ${LIME_YELLOW}$2${NORMAL} from $3"

		#Keeping text until "Dumping", keeping text after "Current"...
		sed -i -e "/-- Dumping events for database '$2'/q" -e '/-- Current Database: `'"$2"'`/,$!d' "$3"

		fname="${3%.*}"_$2.sql
		mv "$3" "$fname"
    ;;

     
  purge)

		if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
			echo "Purge option expects one database name and one mysql dump file."
			usage
			exit 1
		fi
		
		#Making a backup
		cp "$3" "$3.old"

    echo "Purging ${RED}$2${NORMAL} from $3"

		#Keeping from beginning to end
		sed -i "/-- Current Database: \`$2\`/,/-- Dumping events for database '$2'/d" "$3"

		fname="${3%.*}"_purged.sql
		mv "$3" "$fname"
    ;;


    *)
		usage
    exit 1
esac


exit 0
