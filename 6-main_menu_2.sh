#!/bin/bash

tput setaf 2 md
echo "################################"
echo "Connected to ${dbname} DB"
echo "################################"

export oldps3=${PS3}
export PS3="Connected to db '${dbname}', >> "


# Show Main Menu and wait for an input
tbl_choices=("Create Table" "List Tables" "Drop Table" "Insert Into Table" \
"Select From Table" "Delete From Table" "Update Table" "Quit")

while true; do
    tput setaf 1 md
    echo -e "\n"
    echo "Table Main Menu"
    tput setaf 7 md
    echo "1- Create Table"
    echo "2- List Tables"
    echo "3- Drop Table"
    echo "4- Insert Into Table"
    echo "5- Select From Table"
    echo "6- Delete From Table"
    echo "7- Update Table"
    echo "8- Quit"
    tput setaf 1 md
    read -rp "Please enter you choice: " choice
    case ${choice} in 
        1) clear
        tput setaf 3 md
        source ../../7-create_tbl.sh 
        ;;
        2) clear
        tput setaf 3 md
        source ../../8-list_tbl.sh 
        ;;
        3) clear
        source ../../8-list_tbl.sh
        tput setaf 3 md
        source ../../9-drop_tbl.sh
        ;;
        4) clear
        source ../../8-list_tbl.sh
        tput setaf 3 md
        source ../../10-insert_tbl.sh
        ;;
        5) clear
        source ../../8-list_tbl.sh
        tput setaf 3 md
        source ../../11-select_tbl.sh
        ;;
        6) clear
        source ../../8-list_tbl.sh
        tput setaf 3 md
        source ../../12-delete_tbl.sh
        ;;
        7) clear
        source ../../8-list_tbl.sh
        tput setaf 3 md
        source ../../13-update_tbl.sh
        ;;
        8) export PS3=${oldps3}
        break
        ;;
        *) tput setaf 1 md
        echo "Invalid input, please choose from 1 to 8" 
        ;;
    esac
done