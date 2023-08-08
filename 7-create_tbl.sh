#!/bin/bash

while true; do
    # Take input from user for table name
    read -rp "Please enter the table name: " tablename

    # Validate the input length
    if [[ ${#tablename} -eq 0 || ${#tablename} -gt 64 ]]; then
      echo "Invalid table name length. Please provide a name between 1 and 64 characters."
      continue
    fi

    # Validate the table name format
    if ! [[ "$tablename" =~ ^[a-zA-Z][a-zA-Z0-9_]{1,64}$ ]]; then
      echo "Invalid table name format. Please provide a name that follows SQL table naming convention."
      continue
    fi

    # Check if the table file already exists
    if [[ -f "${tablename}" ]]; then
      echo "Table '${tablename}' already exists in database '${dbname}'."
      continue
    fi

    # Create the table file
    touch "${tablename}"
    touch ".${tablename}.meta"

    # alias the meta file name
    meta_file=".${tablename}.meta"

    echo "column_name:data_type:pk" > ${meta_file}
    echo "Table '${tablename}' created successfully in database '${dbname}'."
    break
done

while true; do
    # Prompt the user for the number of columns
    read -rp "Enter the number of columns: " num_columns

    # Check if the input is a valid number
    if ! [[ ${num_columns} =~ ^[1-9][0-9]*$ ]]; then
        echo "Error: Invalid input. Number of columns must be a positive integer."
        continue
    else
        break
    fi
done

# Check columns and data type
# Prompt the user for column details
pk_flag=false
for (( i=1; i<=num_columns; i++ )); do

  # check column name and store it in meta table
  while true; do
    read -rp "Enter Column ${i} name: " col_name
    # Validate the input length
    if [[ ${#col_name} -eq 0 || ${#col_name} -gt 64 ]]; then
      echo "Invalid column name length. Please provide a name between 1 and 64 characters."
      continue
    fi

    # Validate the table name format
    if ! [[ "${col_name}" =~ ^[a-zA-Z][a-zA-Z0-9_]{1,64}$ ]]; then
      echo "Invalid column name format. Please provide a name that follows SQL column naming convention."
      continue
    fi

    echo -ne "${col_name}:" >> ${meta_file}
    break
  done

  # check column data type and store it in meta table
  while true; do
    read -rp "Enter the data type (int/str) for Column ${i}, '${col_name}': " data_type
    
    # Validate the data type
    if [[ "${data_type}" =~ ^[iI][nN][tT]$ ]]; then
      echo -ne "int:" >> ${meta_file}
      break
    elif [[ "${data_type}" =~ ^[sS][tT][rR]$ ]]; then
      echo -ne "str:" >> ${meta_file}
      break
    else
      echo "Error: Invalid data type. Allowed types are 'int' and 'str'."
      continue
    fi
  done

  # Ask if the column is primary key or not
  # and append the column details to the meta file
  if ! ${pk_flag}; then
    while true; do
      read -rp "Do you want column ${i} to be the primary key ? (Y/N) : " choice

      case ${choice} in
        @([yY])) pk_flag=true
        echo "Column ${i} has been selected as primary key"
        echo -ne "yes\n" >> ${meta_file}
        break
        ;;
        @([nN])) 
        echo "Column ${i} is a normal column"
        echo -ne "no\n" >> ${meta_file}
        break
        ;;
        *) echo "Please enter either (Y/N)"
        continue
        ;;
      esac

    done

  else
    echo -ne "no\n" >> ${meta_file}
  fi

done

# Check if the column name is repeated or not and add suffix to it
awk -F ":" '{
    col = $1;
    if (seen[col] == "") {
      seen[col] = 1;
    } 
    else {
      suffix = seen[col]++;
      $1 = col "_" suffix;
    }
    printf $1;
    for (i = 2; i <= NF; i++) {
      printf ":%s", $i;
    }
    printf "\n";
  }' "${meta_file}" > temp_file

mv temp_file "${meta_file}"
