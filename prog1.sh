#! /bin/bash
#chmod +x prog1.sh g gives executable permission

#if [[ $REPLY == "y" ]] || [[ $REPLY == "Y" ]] then move out the dir

# Contants; add more if necessary
MISSING_ARGS_MSG="src and dest missing"
MORE_ARGS_MSG="Exactly 2 arguments required"
SOURCE_NOT_FOUND="src not found"

# $# is the number of arguments passed in
# $@ is all of the paramters or arguments passed to the function
#mv $loopvar "$dest/$loopvar"
 
if (($# == 0)) #equal to 0 arguments
then
    echo "$MISSING_ARGS_MSG"
    exit 0
fi

if (($# > 2)) #Greater than 2 arguments
then
    echo "$MORE_ARGS_MSG"
    exit 0
fi 

if (($# == 2)) && [[ ! -d $1 ]] #-d checks if the directory exists in system
then
    echo "$SOURCE_NOT_FOUND"
    exit 0
fi

if [[ ! -d $2 ]] #if destination directory does not exist
then
   mkdir $2
else
   rm -r $2 #deletes destination directory
   mkdir $2 #recreates it
fi

for direct in $(find $1 -type d) 
 do
   numbr=$( find $direct -maxdepth 1 -type f -name *.c | wc -l)
   if [ "$numbr" -gt 0 ]; 
   then
     if [ "$numbr" -gt 3 ]; 
      then
      #more than 3 files, takes input from user
      echo $( find $1 -maxdepth 1 -name *.c ) # displays the c files
      read -r -p "There are more than 3 files to move, would you want to continue still ?" input
      if [[ $input == "Y" ]] || [[ $input == "y" ]]; 
        then
           mkdir -p $2/$direct #for handling the paths with the folders
           for file in $(find $direct -maxdepth 1 -type f -name *.c)
              do
                mv $file $2/$direct
              done
       fi
      else
       foldr=$(find $direct -maxdepth 1 -type f -name *.c)
       mkdir -p $2/$direct #adds direction to dest path helps create subdirectories
       for file in $(find $direct -maxdepth 1 -type f -name *.c)
        do
          mv $file $2/$direct
        done
      fi
    fi
done
