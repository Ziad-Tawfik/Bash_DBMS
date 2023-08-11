#!/bin/bash

while true; do
    tput setaf 3 md
    # Take input from user for db name
    read -rp "Please enter the database name you want to drop: " dbname

    # Validate that length of name is not zero 
    if [[ -z ${dbname} ]]; then
        tput setaf 1 md
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Confirm that user really wants to delete the db
    if [[ -d ${dbname} ]]; then
        tput setaf 1 md
        read -rp "Are you sure You Want To Delete ${dbname} ? (Y/N) : " choice
        case $choice in
                @([yY]) ) rm -r ${dbname}
                tput setaf 2 md
                echo "${dbname} DB has been deleted successfully, going back to main menu"
                break
                ;;
                @([nN]) ) tput setaf 2 md
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
        echo "${dbname} doesn't exist"
        continue
    fi

done