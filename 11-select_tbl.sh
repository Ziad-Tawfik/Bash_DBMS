#!/bin/bash

if [[ $(ls | wc -l) -eq 0 ]]; then
    return 1
fi

while true; do
  tput setaf 3 md
  # Take input from user for table name
  read -rp "Please enter the table name you want to select data from it or type exit to return to main menu: " tablename

  if [[ "${tablename}" =~ ^[eE][xX][iI][tT]$ ]]; then
        return 1
  fi
  
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
#IFS=","
IFS=":"
col=$(cut -d : -f 1 ${meta_file} | sed -n '2,$p')
readarray -t col_arr <<< "${col}"

while true; do
    tput setaf 7 md
    echo -e "\n"
    echo "1- Retrieve all rows"
    echo "2- Retrieve a specific rows"
    echo "3- Quit"
    tput setaf 1 md
    read -rp "Please enter you choice: " choice
    
    case ${choice} in 
    1) tput setaf 7 md
    echo "###########################"
    tput setaf 2 md
    echo "$(echo "${col_arr[*]}" | cat - ${tablename} | column -t -s :)"
    tput setaf 7 md
    echo "###########################"
    ;;
    2) # Take input from user for record pk value
    pk_column_no=$(($(cut -d : -f3 ${meta_file} | egrep -in yes | cut -d : -f1) - 1))
    tput setaf 3 md
    read -rp "Please enter the row pk to select data: " view_pk
    row=$(awk -F ":" -v pk=${pk_column_no} -v chk=${view_pk} '{
      if ($pk == chk) {
          print $0
          }
        }' ${tablename})
    if [[ -n ${row} ]]; then
      tput setaf 7 md
      echo "###########################"
      tput setaf 2 md
      echo "$(echo -e "${col_arr[*]}\n${row}" | column -t -s :)"
      tput setaf 7 md
      echo "###########################"
    else
      tput setaf 1 md
      echo "No data found matching your criteria please enter a valid pk"
    fi
    ;;
    3) IFS="${oldifs}"
    break
    ;;
    *) tput setaf 1 md
    echo "Invalid input, please choose from 1 to 3" 
    ;;
    esac
done

IFS="${oldifs}"
