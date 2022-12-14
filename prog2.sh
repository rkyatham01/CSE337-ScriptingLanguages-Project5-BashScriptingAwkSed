#!/bin/bash

# Constants; add more if necessary
WRONG_ARGS_MSG="data file or output file missing"
FILE_NOT_FOUND_MSG="file not found"

if (($# != 2)) #not equal to 2 arguments
then
    echo "$WRONG_ARGS_MSG"
    exit 0
fi

if [[ ! -f $1 ]] #-d checks if the directory exists in system
then
    #basename allows us to retrieve the basename executable in UNIX
    echo "$(basename ${1}) $FILE_NOT_FOUND_MSG"
    exit 0
fi

if [[ ! -f $2 ]] #-d checks if the directory exists in system
then
    #creating output file if the file doesn't exist
    touch $2
fi
# $1 is input file
# $2 is output file
declare -a ArrSum
let count=0

awk -F '[;:,]' '{for (i=1;i<=NF;i++) ArrSum[i]+=$i}; END{for (i in ArrSum) print "Col "i" : " ArrSum[i];}' $1 >> $2
exit 1
