#!/bin/bash

#Constants; add more if necessary
MISSING_ARGS_MSG="Missing data file"

#!/bin/bash

if [[ ! -f $1 ]] #not a valid data file error
then
    echo $MISSING_ARGS_MSG
    exit 0
fi

# $1 is data file
# $2 to N are optional arguments for weights 

fileStored=$1 #file is stored here
shift; #shifts the thing by 1
arrArgs=$@

awk -v var="$arrArgs" '
  BEGIN { FS = " " }
  {
  split(var, splitArr, " ");
  lines = 0
  sum = 0;

  for (i=1;i<=NF-1;i++)
    if (!splitArr[i]){
      splitArr[i] = 1
      sum += splitArr[i]
    }
    else
      sum += splitArr[i]
  }

  {
  sumSplit = 0
  for (i=1;i<=NF;i++)
    sumSplit += $i * splitArr[i-1]
    finalSum += sumSplit / sum
  }

  END {
      print int(finalSum / (NR-1))

  }' $fileStored
