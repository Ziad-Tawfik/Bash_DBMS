#!/bin/bash

while true; do
    tput setaf 3 md
    # Take input from user for table name
    read -rp "Please enter the table name you want to delete data from it: " tablename

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

# Get all column names and add it as a header to the file
oldifs="$IFS"
IFS=","
col=$(cut -d : -f 1 ${meta_file} | sed -n '2,$p')
readarray -t col_arr <<< "${col}"

while true; do
    tput setaf 7 md
    echo -e "\n"
    echo "1- Delete all rows"
    echo "2- Delete a specific rows"
    echo "3- Quit"
    tput setaf 1 md
    read -rp "Please enter you choice: " choice
    
    case ${choice} in 
    1) tput setaf 1 md
    read -rp "Are you sure you want to delete all rows in ${tablename} ? (Y/N) : " del_choice
        if [[ ${del_choice} =~ ^[Yy]$ ]]; then
            truncate -s 0 ${tablename}
            tput setaf 2 md
            echo "All rows in ${tablename} have been deleted, going back to main menu"
            break
        elif [[ ${del_choice} =~ ^[Nn]$ ]]; then
            tput setaf 2 md
            echo "Operation cancelled, going back to main menu"
            break
        else
            tput setaf 1 md
            echo "Invalid Option"
        fi
    ;;
    2) # Take input from user for record pk value
    pk_column_no=$(($(cut -d : -f3 ${meta_file} | egrep -in yes | cut -d : -f1) - 1))
    tput setaf 3 md
    read -rp "Please enter the row pk to delete it: " del_pk
    rows=$(awk -F ":" -v pk=${pk_column_no} -v chk=${del_pk} '{
      if ($pk != chk) {
          print $0
          }
        }' ${tablename})
    if [[ $(echo "${rows}" | wc -l) != $(cat ${tablename} | wc -l) ]]; then
        echo "${rows}" > "${tablename}"
        tput setaf 5 md
        echo "Current data in ${tablename} after deletion of '${del_pk}' row"
        tput setaf 7 md
        echo "###########################"
        tput setaf 2 md
        echo "$(cat ${tablename} | column -t -s : -N "${col_arr[*]}")"
        tput setaf 7 md
        echo "###########################"
    else
        tput setaf 1 md
        echo "No data found matching your criteria please enter a valid pk"
    fi
    ;;
    3) break
    ;;
    *) tput setaf 1 md
    echo "Invalid input, please choose from 1 to 3" 
    ;;
    esac
done

IFS="${oldifs}"
