#!/bin/bash

while true; do
    echo "chkpoint 1 in script 4 :: $(pwd)"
    # Take input from user for db name
    read -rp "Please enter the database name you want to connect to: " dbname

    # Validate that length of name is not zero 
    if [[ -z ${dbname} ]]; then
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        source ${dirpath}/3-list_db.sh
        continue
    fi

    # Validate that directory exists
    if [[ -d ${dbname} ]]; then
        cd ${dbname}
        echo "chkpoint 1 in script 4 :: $(pwd)"
        source ${dirpath}/6-main_menu_2.sh ${dbname}
        echo "chkpoint 2 in script 4 :: $(pwd)"
        cd ${dirpath}/DBMS
        echo "chkpoint 3 in script 4 :: $(pwd)"
    else
        echo "${dbname} doesn't exist"
        source ${dirpath}/3-list_db.sh
        continue
    fi

done