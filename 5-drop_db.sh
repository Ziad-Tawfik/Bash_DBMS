#!/bin/bash

while true; do
    # Take input from user for db name
    read -rp "Please enter the database name you want to drop: " dbname

    # Validate that length of name is not zero 
    if [[ -z ${dbname} ]]; then
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Confirm that user really wants to delete the db
    if [[ -d ${dbname} ]]; then
        read -p "Are you sure You Want To Delete ${dbname} ? (Y/N) : " choice
        case $choice in
                @([yY]) ) rm -r ${dbname}
                echo "${dbname} DB has been deleted successfully, going back to main menu"
                break
                ;;
                @([nN]) ) echo "Operation cancelled, going back to main menu"
                break
                ;;
                *) echo "Invalid option"
                continue
                ;;
        esac
    else
        echo "${dbname} doesn't exist"
        continue
    fi

done