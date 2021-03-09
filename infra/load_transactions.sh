#!/bin/bash
#------------------------------------------
# loads data from s3 into required table
#------------------------------------------
set -o errexit
set -u

#Set environmental variables
. ~/virtualenv/.convex/.Env

#------------------------------------------
# Version  Author
# 1.00     None
#------------------------------------------
jobname=$0


#---------------------------------------------
# purge the data from the Snowflake load table
#---------------------------------------------

 snowsql -c convex -q "use role SYSADMIN; use warehouse convex_load_dwh; truncate convex.load.raw_transactions" -o echo=true

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

#-----------------------------------
# Run the Snowflake load / copy into
#-----------------------------------

 snowsql -c convex -o echo=true \
 -q "USE ROLE SYSADMIN; use warehouse convex_load_dwh; copy into convex.load.raw_transactions \
 from  @CONVEX.PROD.S3_LOAD_STAGE/transactions \
 file_format = ( type = json );"

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "****************************************** "
        echo " > $jobname has failed with return code $rc"
        echo "****************************************** "
        exit $rc
    fi

 echo "$jobname.sh load transactions data from s3 completed OK"

