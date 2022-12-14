#!/bin/bash

# Constants; add more if necessary

MISSING_ARGS_MSG="Score directory missing"
ERR_MSG="not a directory"

if (($# != 1)) #extra arguements passed in or none
then
    echo "$MISSING_ARGS_MSG"
    exit 0
fi 

if [[ ! -d $1 ]] #-d checks if the directory exists in system
then
    echo "$1 $ERR_MSG"
    exit 0
fi

for file in $(find $1 -name prob4-score*.txt)
do 
    awk 'BEGIN { FS = "," }
    {
    if (NR!=1){
      for (i=2;i<=NF;i++){
        curSum += ($i / 10)
       }
      studendID=$1
      curSum = (curSum / 5) * 100
     }
    }

    END {

    if (curSum >= 93){
       print studendID " : A";
    }
    else if (curSum >= 80){
       print studendID " : B";
    }
    else if (curSum >= 65){
       print studendID " : C";
    }
    else {
       print studendID " : D";
    }

    }' $file

done


