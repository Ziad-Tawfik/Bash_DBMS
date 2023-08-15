#!/bin/bash
if [[ $(ls | wc -l) -eq 0 ]]; then
    return 1
fi

while true; do
    tput setaf 3 md
    # Take input from user for db name
    read -rp "Please enter the database name you want to connect to or type exit to get back to main menu: " dbname

    # Validate that length of name is not zero 
    if [[ -z ${dbname} ]]; then
        tput setaf 1 md
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        source ${dirpath}/3-list_db.sh
        continue
    fi

    if [[ ${dbname} =~ [Ee][Xx][Ii][Tt] ]]; then
        break
    fi

    # Validate that directory exists
    if [[ -d ${dbname} ]]; then
        tput setaf 2 md
        clear
        cd ${dbname}
        source ../../6-main_menu_2.sh ${dbname}
        cd ..
        clear
        break
    else
        tput setaf 1 md
        echo "${dbname} doesn't exist"
        source ${dirpath}/3-list_db.sh
        continue
    fi

done