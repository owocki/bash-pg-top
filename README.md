# bash-pg-top

A bash port of pg_top.  Run as the `postgres` user on your machine, and make sure to configure the `PORT` if needed.  

Source of bash script is here: https://github.com/owocki/bash-pg-top/blob/master/pg_top.sh

The output looks something like this:

```
Wed Jul  8 19:41:09 CDT 2015
HOSTNAME
 19:41:09 up 746 days, 23:12,  2 users,  load average: 0.48, 0.70, 0.62
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0 2340920 964948   8776 2372544    2    1    30    41    0    0  2  0 97  1
 ----- active/ DBNAME -----
 - - - - - -  age | usename | pid | backend_start | query_start | waiting | state | query
 - - - - - - -----+---------+-----+---------------+-------------+---------+-------+-------
 - - - - - - (0 rows)
 - - - - - -
 ----- / active/DBNAME -----
 ----- idle/ DBNAME -----
 - - - - - -  age | usename | pid | backend_start | query_start | waiting | state | query
 - - - - - - -----+---------+-----+---------------+-------------+---------+-------+-------
 - - - - - - (0 rows)
 - - - - - -
 ----- / idle/DBNAME -----
 ```

As you can see, 

* the datetime is displayed in the first line.
* the hostname is displayed in the second.
* uptime information in the third
* vmstat info in the third
* the next several lines are the active postgres queries
* the next several lines are the idle postgres queries

How to use:

* Press `<enter>` to see the next screen.
* Enter `kill <pid>` and press `<enter>` to kill a process with `pg_cancel_backend()`
* Enter `hkill <pid>` and press `<enter>` to hard kill a process with `pg_terminate_backend()`
* Enter `psql` and press `<enter>` to enter psql command line.
* Enter `exit` and press `<enter>` to exit `bash_pg_top`.

<!-- Google Analytics --> 
<img src='https://ga-beacon.appspot.com/UA-1014419-15/owocki/bash-pg-top' style='width:1px; height:1px;' >


