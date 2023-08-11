#!/bin/bash

while true; do
    tput setaf 3 md
    # Take input from user for table name
    read -rp "Please enter the table name you want to insert data into it: " tablename

    # Check if the table file already exists
    if ! [[ -f "${tablename}" ]]; then
        tput setaf 1 md
        echo "Table '${tablename}' doesn't exist in database '${dbname}'."
        continue
    fi

    # alias the meta file name
    meta_file=".${tablename}.meta"

    tput setaf 2 md
    echo "Table '${tablename}' has been selected from '${dbname}'."
    break
done

# Take number of records user want to insert
while true; do
    tput setaf 3 md
    # Take input from user for table name
    read -rp "Please enter the number of rows you want to insert into the table: " rows_no

    # Check if the input is a valid number
    if ! [[ ${rows_no} =~ ^[1-9][0-9]*$ ]]; then
        tput setaf 1 md
        echo "Error: Invalid input. Number of rows must be a positive integer."
        continue
    else
        break
    fi
done

# Get the number of cols
num_columns=$(cat ${meta_file} | cut -d ":" -f 1 | wc -l)
tput setaf 2 md
echo "number of columns is ${num_columns}"

for (( j=1; j<=${rows_no}; j++ )); do
    # Create empty record to save data in it
    row=''

    # Get name, data type of each column and if it is pk or not
    for (( i=2; i<=${num_columns}; i++ )); do

        col_meta=$(sed -n "${i}p" ${meta_file})
        col_name=$(cut -d ":" -f 1 <<< ${col_meta})
        col_type=$(cut -d ":" -f 2 <<< ${col_meta})
        col_pk=$(cut -d ":" -f 3 <<< ${col_meta})

        if [[ ${col_pk,,} == "yes" ]]; then
            tput setaf 5 md
            echo "Note: This column '${col_name}' is a primary key and must be unique!"
        fi

        while true; do
            tput setaf 3 md
            read -rp "enter the value of column (${col_name}) that has the type (${col_type}): " ip_value

            found=$(cut -d ":" -f $((i-1)) ${tablename} | egrep -iw ^"${ip_value}"$)
            
            # Check pk is unique or not
            if [[ ${col_pk,,} == "yes" ]] && [[ -n ${found} ]]; then
                tput setaf 1 md
                echo "Error, Primary key must be unique please enter another value"
                continue
            fi
            
            # Check Data type
            if [[ "${col_type}" == "int" && "${ip_value}" =~ ^[0-9]+$ ]]; then
                # Populate the data into the row
                if [[ -z ${row} ]]; then
                    row=${ip_value}
                else
                    row="${row}:${ip_value}"
                fi
                break
            elif [[ "${col_type}" == "str" && "${ip_value}" =~ ^[a-zA-Z0-9@' '_.]+$ ]]; then
                # Populate the data into the row
                if [[ -z ${row} ]]; then
                    row=${ip_value}
                else
                    row="${row}:${ip_value}"
                fi
                break
            else
                tput setaf 1 md
                echo "Input '${ip_value}' doesn't match the data type '${col_type}' for column '${col_name}', please try again"
                continue
            fi
        done
    done
    # Append the record to the table
    echo ${row} >> ${tablename} 
done

tput setaf 2 md
echo "Data has been inserted into the table successfully!"