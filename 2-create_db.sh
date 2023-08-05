#!/bin/bash

while true; do
    # Take input from user for db name
    read -rp "Please enter the database name: " dbname

    # Validate dbname length
    if [[ ${#dbname} -eq 0 || ${#dbname} -gt 64 ]]; then
        echo "Invalid database name length. Please provide a name between 1 and 64 characters or type exit to break."
        continue
    fi

    # Validate dbname format
    if ! [[ "$dbname" =~ ^[a-zA-Z][a-zA-Z0-9_]{1,64}$ ]]; then
        echo "Invalid database name format. Please provide a name that follows MySQL naming convention or type exit to break."
        continue
    fi

    # Check if the directory already exists
    if [[ -d "${dbname}" ]]; then
        echo "Database ${dbname} already exists. Please provide another name or type exit to break."
        continue
    fi

    if [[ "${dbname}" =~ ^[eE][xX][iI][tT]$ ]]; then
        break
    fi

    # Create the directory
    mkdir "${dbname}"
    echo "Database ${dbname} created successfully."
    break

done