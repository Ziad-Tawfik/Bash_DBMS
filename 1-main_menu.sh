#!/bin/bash
shopt -s extglob

clear
tput setab 0 md
tput setaf 1 md
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

tput setaf 2 md
cd ${dirpath}/DBMS/
echo "Current DBMS directory: $(pwd)"
echo "######################################"

# Show Main Menu and wait for an input
while true; do
    tput setaf 1 md
    echo -e "\n"
    echo "DB Main Menu:"
    tput setaf 7 md
    echo "1- Create DB"
    echo "2- List DBs"
    echo "3- Connect to DB"
    echo "4- Drop DB"
    echo "5- Quit"
    tput setaf 1 md
    read -rp "Please enter you choice: " choice
    case $choice in 
        1) clear
        tput setaf 3 md
        source ../2-create_db.sh
        ;;
        2) clear
        tput setaf 3 md 
        source ../3-list_db.sh 
        ;;
        3) clear
        tput setaf 3 md
        source ../3-list_db.sh   # list current DBs first
        source ../4-connect_db.sh 
        ;;
        4) clear
        tput setaf 3 md
        source ../3-list_db.sh   # list current DBs first
        source ../5-drop_db.sh
        ;;
        5) break
        ;;
        *) tput setaf 1 md
        echo "Invalid input, please choose from 1 to 5" 
        ;;
    esac
done