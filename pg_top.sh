#!/bin/bash
# pg_top.sh is a bash pg_top ( http://ptop.projects.pgfoundry.org/ ) 
# replacement for folks who for one reason or another cannot 
# install `pg_top` at their place of employment.
# 
# This script is provided without warranty.  Use at your own risk.
# 

PORT=5432
DATABASES=$(echo "\l" | psql -p $PORT | awk '{print $1}' | grep -v '|' | grep -v '-' | grep -v List | grep -v template | grep -v Name | grep -v '(' | grep -v postgres | while read line; do if [ $(echo $line | wc -c) -gt 1 ]; then echo $line; fi; done)
while read line; 
	do 
	clear; 
	date
	hostname -f;
	uptime;
	vmstat;
	if [ "$line" = "" ]; then
		STATES="active idle"
		for DB in $DATABASES; do
			for state in $STATES; do
				echo " ----- $state/ $DB -----";
				echo "SELECT age(clock_timestamp(), backend_start) as age, usename, pid, backend_start, query_start, waiting, state, regexp_replace(query, E'[\\n\\t\\r]+', ' ', 'g' ) as query  FROM pg_stat_activity WHERE state = '$state' and pid != pg_backend_pid() and datname = '$DB' ORDER BY backend_start DESC;" | psql -p $PORT | sed 's/^/ - - - - - - /g' ;
				echo " ----- / $state/$DB -----";
			done
		done
	elif [ $(echo $line | awk '{print $1}') = "hkill" ]; then
		pid=$(echo $line | awk '{print $2}');
		echo "select pg_terminate_backend($pid);" | psql;
	elif [ $(echo $line | awk '{print $1}') = "kill" ]; then
		pid=$(echo $line | awk '{print $2}');
		echo "select pg_cancel_backend($pid);" | psql;
	elif [ $(echo $line | awk '{print $1}') = "psql" ]; then
		psql
	elif [ $(echo $line | awk '{print $1}') = "exit" ]; then
		echo "exiting"
		exit 0
	else
		echo "command not understood"
	fi
done

