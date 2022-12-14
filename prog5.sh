#!/bin/bash

# Constants; add more if necessary

BAD_ARG_MSG_1="missing no. of characters"
BAD_ARG_MSG_2="Third argument must be an integer greater than 0"
FILE_NOT_FOUND_MSG="not a file"

#Takes in 3 arguments
if (($# == 0)) #if no arguments given
then
    echo "input file and  dictionary missing"
    exit 0
fi

if (($# == 1)) #if 1 argument is given
then 
   echo "input file and  dictionary missing"
   exit 0
fi

if [[ -z $3 ]] #if 3rd number is missing 
then
    echo $BAD_ARG_MSG_1
    exit 0
fi

if [[ ! -f $1 ]]
then
   echo $1 $FILE_NOT_FOUND_MSG
   exit 0
fi

if [[ ! -f $2 ]] #if missing dictionary file but have input file
then
   echo $2 $FILE_NOT_FOUND_MSG  
   exit 0
fi

#When u set up a variable make sure u pass it in as a variable pattern or else it doesn't work
reg='^[0-9]+$'
#0 is the only edge case
if ! [[ $3 =~ $reg ]] || [[ $3 -eq 0 ]]; then #checks if the 3rd number is a number gretaer than 0 or not
   echo $BAD_ARG_MSG_2
   exit 0
fi
# $1 is text file
# $2 is dictionary
# $3 is N letter words

input="$1"
input2="$2"
string=$(cat $input | tr -cd "A-Za-z ") #enclosing in $() can put commands into variables
count=0
flag=0 #initial flag initializing

for word in $string 
do
   readWord=$word
   flag=0
   count=$((count+1))
    if [ ${#readWord} -eq $3 ]
    then
      while read word2 
      do
         dictWord=$word2 
         word1="${readWord,,}"
         word2="${dictWord,,}"
         newStringWord2=${word2:0:$3}

         if [[ "$word1" == "$newStringWord2" ]]
         then
            flag=1 #sets it if found
            break
         fi
      done <$input2
      if [ $flag -eq 0 ]
      then
         echo "$word1; word position=$count"
      fi
    fi
 done