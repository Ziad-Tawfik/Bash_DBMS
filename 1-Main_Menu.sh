#!/bin/bash

echo "######################################"
echo "##### Welcome to DBMS Using Bash #####"
echo "##### Developed by 'Zyad Tawfik' #####"
echo "######################################"

path=$(dirname $0)
PS3='Please enter your choice > '

# Check if DBMS folder exists or not
if ! [[ -d "${path}/DBMS/" ]]; then
    mkdir -p ${path}/DBMS/
    echo -e "DBMS Directory has been created in the following path \n${path}/DBMS"
fi

# Show Main Menu and wait for an input
choices=("Create DB" "List DBs" "Connect To DB" "Drop DB" "Quit")
while true
do
    select choice in "${choices[@]}"
    do
        echo $choice
        echo $REPLY
        case $REPLY in 
            1) echo "this is option 1"
            #source ${path}/2-create_db.sh 
            ;;
            2) echo "this is option 2"
            #source ${path}/3-create_db.sh 
            ;;
            3) echo "this is option 3"
            #source ${path}/4-create_db.sh 
            ;;
            4) echo "this is option 4"
            #source ${path}/5-create_db.sh 
            ;;
            5) break 2
            ;;
            *) echo "Invalid input, please choose from 1 to 5" 
            ;;
        esac
    done
done