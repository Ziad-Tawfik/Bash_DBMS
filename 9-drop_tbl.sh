#!/bin/bash

while true; do
    tput setaf 3 md
    # Take input from user for table name
    read -rp "Please enter the table name you want to drop: " tblname

    # Validate that length of name is not zero 
    if [[ -z ${tblname} ]]; then
        tput setaf 1 md
        echo "Invalid table name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Confirm that user really wants to delete the table
    if [[ -f ${tblname} ]]; then
        tput setaf 1 md
        read -rp "Are you sure You Want To Drop the whole table ${tblname} ? (Y/N) : " choice
        case $choice in
            @([yY])) rm ${tblname} .${tblname}.meta 2> /dev/null
            tput setaf 2 md
            echo "${tblname} table and .${tblname}.meta have been deleted successfully, going back to main menu"
            break
            ;;
            @([nN])) tput setaf 2 md
            echo "Operation cancelled, going back to main menu"
            break
            ;;
            *) tput setaf 1 md
            echo "Invalid option"
            continue
            ;;
        esac
    else
        tput setaf 1 md
        echo "${tblname} doesn't exist"
        continue
    fi

done