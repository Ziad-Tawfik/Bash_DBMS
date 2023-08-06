#!/bin/bash

echo "################################"
echo "##### Connected to ${dbname} DB #####"
echo "################################"

export oldps3=${PS3}
export PS3="Connected to db '${dbname}', >> "

echo $(pwd)
# Show Main Menu and wait for an input
tbl_choices=("Create Table" "List Tables" "Drop Table" "Insert Into Table" \
"Select From Table" "Delete From Table" "Update Table" "Quit")

select choice in "${tbl_choices[@]}"
do
    case $REPLY in 
        1) source ${dirpath}/7-create_tbl.sh 
        ;;
        2) echo this is option 2 
        #source ${dirpath}/8-list_tbl.sh 
        ;;
        3) echo this is option 3 
        # source ${dirpath}/8-list_tbl.sh
        # source ${dirpath}/9-drop_tbl.sh
        ;;
        4) echo this is option 4 
        #source ${dirpath}/9-insert_tbl.sh
        ;;
        5) echo this is option 5
        # source ${dirpath}/10-select_tbl.sh
        ;;
        6) echo this is option 6
        # source ${dirpath}/11-delete_tbl.sh
        ;;
        7) echo this is option 7
        # source ${dirpath}/12-update_tbl.sh
        ;;
        8) export PS3=${oldps3}
        break
        ;;
        *) echo "Invalid input, please choose from 1 to 8" 
        ;;
    esac
done