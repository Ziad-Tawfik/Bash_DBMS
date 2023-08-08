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
while true; do
    echo "1- Create DB"
    echo "2- List DBs"
    echo "3- Connect to DB"
    echo "4- Drop DB"
    echo "5- Quit"
    read -rp "Please enter you choice: " choice
    case $choice in 
        1) source ${dirpath}/2-create_db.sh
        ;;
        2) source ${dirpath}/3-list_db.sh 
        ;;
        3) echo "chkpoint 1 in script 1 :: $(pwd)"
        source ${dirpath}/3-list_db.sh   # list current DBs first
        source ${dirpath}/4-connect_db.sh 
        ;;
        4) source ${dirpath}/3-list_db.sh   # list current DBs first
        source ${dirpath}/5-drop_db.sh
        ;;
        5) break
        ;;
        *) echo "Invalid input, please choose from 1 to 5" 
        ;;
    esac
done