#!/bin/bash

while true; do
    # Take input from user for table name
    read -rp "Please enter the table name you want to drop: " tblname

    # Validate that length of name is not zero 
    if [[ -z ${tblname} ]]; then
        echo "Invalid table name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Confirm that user really wants to delete the table
    if [[ -f ${tblname} ]]; then
        read -rp "Are you sure You Want To Drop the whole table ${tblname} ? (Y/N) : " choice
        case $choice in
            @([yY])) rm ${tblname} .${tblname}.meta
            echo "${tblname} table and .${tblname}.meta have been deleted successfully, going back to main menu"
            break
            ;;
            @([nN])) echo "Operation cancelled, going back to main menu"
            break
            ;;
            *) echo "Invalid option"
            continue
            ;;
        esac
    else
        echo "${tblname} doesn't exist"
        continue
    fi

done