#!/bin/bash

while true; do
    tput setaf 3 md
    # Take input from user for db name
    read -rp "Please enter the database name or type exit to get back to main menu: " dbname

    # Validate dbname length
    if [[ ${#dbname} -eq 0 || ${#dbname} -gt 64 ]]; then
        tput setaf 1 md
        echo "Invalid database name length. Please provide a name between 1 and 64 characters."
        continue
    fi

    # Validate dbname format
    if ! [[ "$dbname" =~ ^[a-zA-Z][a-zA-Z0-9_]{0,63}$ ]]; then
        tput setaf 1 md
        echo "Invalid database name format. Please provide a name that follows SQL naming convention."
        continue
    fi

    # Check if the directory already exists
    if [[ -d "${dbname}" ]]; then
        tput setaf 1 md
        echo "Database ${dbname} already exists. Please provide another name."
        continue
    fi

    if [[ "${dbname}" =~ ^[eE][xX][iI][tT]$ ]]; then
        break
    fi

    # Create the directory
    mkdir "${dbname}"
    tput setaf 2 md
    echo "Database ${dbname} created successfully."
    break

done