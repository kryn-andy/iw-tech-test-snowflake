#!/bin/bash
#-----------------------------
# copy transactions data to S3
#-----------------------------

set -o errexit
set -u

jobname=$0

 aws s3 cp /home/tndlol5/virtualenv/.convex/input_data/starter/transactions s3://convins/load/transactions/ --recursive --include "*.*" --sse aws:kms

 rc=$?
 if [ $rc -ne 0 ]
    then
        echo "$jobname.sh has failed copying data to s3"
        exit $rc
 fi

 echo "$jobname.sh copy transactions data to s3 completed OK"
