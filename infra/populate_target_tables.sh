#!/bin/bash
#-----------------------------------------------------
# Populate the prod target warehouse tables for convex
#-----------------------------------------------------
set -o errexit
set -u

#Set environmental variables
. ~/virtualenv/.convex/.Env

#------------------------------------------
# Version  Author
# 1.00     None
#------------------------------------------
jobname=$0

#-------------------------
# Run the populationscript
#-------------------------

 snowsql -c convex -f $SQL_DIR/populate_target_tables.sql

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

 echo " > $jobname populate prod target tables has completed OK"
