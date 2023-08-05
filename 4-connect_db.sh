#!/bin/bash

while true; do
    # Take input from user for db name
    read -rp "Please enter the database name you want to connect to: " dbname

    # Validate that length of name is not zero 
    if [[ -z ${dbname} ]]; then
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Validate that directory exists
    if [[ -d ${dbname} ]]; then
        cd ${dbname}
        echo $(pwd)
        source ${dirpath}/6-main_menu_2.sh ${dbname}
        break
    else
        echo "${dbname} doesn't exist"
        continue
    fi

done