#!/bin/bash
#------------------------------------------
# Create the snowflake warehouse for convex
#------------------------------------------
set -o errexit
set -u

#Set environmental variables
. /home/tndlol5/virtualenv/.convex/.Env

#------------------------------------------
# Version  Author
# 1.00     None
#------------------------------------------
jobname=$0

#-----------------------
# Create the environment
#-----------------------

 snowsql -c convex -f $SQL_DIR/create_environment.sql

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

#-----------------------
# Create the load tables
#-----------------------

 snowsql -c convex -f $SQL_DIR/create_load_tables.ddl

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

#-----------------------
# Create the prod tables
#-----------------------

 snowsql -c convex -f $SQL_DIR/create_prod_tables.ddl

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

#-----------------------
# Create the prod views
#-----------------------

 snowsql -c convex -f $SQL_DIR/create_prod_views.ddl 

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

