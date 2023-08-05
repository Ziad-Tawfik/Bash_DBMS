#!/bin/bash
shopt -s extglob

echo "######################################"
echo "##### Welcome to DBMS Using Bash #####"
echo "##### Developed by 'Zyad Tawfik' #####"
echo "######################################"

export dirpath=$(dirname $0)
export PS3='Please enter your choice (press enter to view the menu) > '

# Check if DBMS folder exists or not
if ! [[ -d "${dirpath}/DBMS/" ]]; then
    mkdir -p ${dirpath}/DBMS/
    echo -e "DBMS Directory has been created in the following path \n${path}/DBMS"
fi

cd ${dirpath}/DBMS/
pwd
# Show Main Menu and wait for an input
choices=("Create DB" "List DBs" "Connect To DB" "Drop DB" "Quit")
while true
do
    select choice in "${choices[@]}"
    do
        case $REPLY in 
            1) source ${dirpath}/2-create_db.sh 
            ;;
            2) source ${dirpath}/3-list_db.sh 
            ;;
            3) source ${dirpath}/3-list_db.sh   # list current DBs first
            source ${dirpath}/4-connect_db.sh 
            ;;
            4) source ${dirpath}/3-list_db.sh   # list current DBs first
            source ${dirpath}/5-drop_db.sh
            ;;
            5) break 2
            ;;
            *) echo "Invalid input, please choose from 1 to 5" 
            ;;
        esac
    done
done