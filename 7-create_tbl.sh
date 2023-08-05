#!/bin/bash

while true; do
    # Take input from user for db name
    read -rp "Please enter the table name: " tablename

    # Validate the input length
    if [[ ${#tablename} -eq 0 || ${#tablename} -gt 64 ]]; then
      echo "Invalid table name length. Please provide a name between 1 and 64 characters."
      continue
    fi

    # Validate the table name format
    if ! [[ "$tablename" =~ ^[a-zA-Z][a-zA-Z0-9_]{1,64}$ ]]; then
      echo "Invalid table name format. Please provide a name that follows MySQL naming convention."
      continue
    fi

    table_file="${tablename}"

    # Check if the table file already exists
    if [[ -f "$table_file" ]]; then
      echo "Table '$tablename' already exists in database '$dbname'."
      continue
    fi

    touch "$table_file"
    echo "Table '$tablename' created successfully in database '$dbname'."
    break
done
