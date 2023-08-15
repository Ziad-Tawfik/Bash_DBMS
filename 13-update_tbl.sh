#!/bin/bash

if [[ $(ls | wc -l) -eq 0 ]]; then
    return 1
fi

while true; do
    tput setaf 3 md
    # Take input from user for table name
    read -rp "Please enter the table name you want to update data in it or type exit to return to main menu: " tablename
    
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
IFS=":"
col=$(cut -d : -f 1 ${meta_file} | sed -n '2,$p')
readarray -t col_arr <<< "${col}"

tput setaf 7 md
echo "###########################"
tput setaf 2 md
echo "$(echo "${col_arr[*]}" | cat - ${tablename} | column -t -s :)"
tput setaf 7 md
echo "###########################"

while true; do
    # Print column names
    tput setaf 5 md
    echo "Current columns in this table"
    tput setaf 7 md
    echo "#############################"
    tput setaf 2 md
    for (( i=0; i<${#col_arr[@]}; i++ )); do
        echo "$((${i}+1))- ${col_arr[$i]}"
    done
    tput setaf 7 md
    echo "#############################"

    # Receive input from user for column name
    tput setaf 3 md
    read -rp "Please enter the column no. you want to update it: " col_no
    if [[ ! ${col_no} =~ ^[1-9][0-9]*$ ]] || [[ ${col_no} -gt ${#col_arr[@]} ]]; then
        tput setaf 1 md
        echo "Invalid input"
        continue
    else
        break
    fi
done

while true; do
    # Get column meta data
    col_meta=$(sed -n "$((${col_no}+1))p" ${meta_file})
    col_name=$(cut -d ":" -f 1 <<< ${col_meta})
    col_type=$(cut -d ":" -f 2 <<< ${col_meta})
    col_pk=$(cut -d ":" -f 3 <<< ${col_meta})

    if [[ ${col_pk,,} == "yes" ]]; then
        tput setaf 5 md
        echo "Note: This column '${col_name}' is a primary key and must be unique!"
    fi

    # Receive input from user for row no. & check pk found or not
    tput setaf 3 md
    pk_column_no=$(($(cut -d : -f3 ${meta_file} | egrep -in yes | cut -d : -f1) - 1))
    pk_values=$(cut -d : -f ${pk_column_no} ${tablename})
    pk_column_name=$(tail -n +2 ${meta_file} | cut -d : -f 1 | sed -n "${pk_column_no} p")
    read -rp "Please enter the pk value '${pk_column_name}' for the row you want to update it: " row_no
    found=$(echo ${pk_values} | egrep -iw ^"${row_no}"$)
    
    if [[ -z ${found} ]]; then
        tput setaf 1 md
        echo "Invalid pk value"
        continue
    else
        break
    fi
done

while true; do
    # Take the value input that user want to update
    tput setaf 3 md
    read -rp "enter the value of column (${col_name}) at row with pk (${row_no})that has the type (${col_type}): " ip_value

    found=$(echo ${pk_values} | egrep -iw ^"${ip_value}"$)
    
    # Check pk is unique or not
    if [[ ${col_pk,,} == "yes" ]] && [[ -n ${found} ]]; then
        tput setaf 1 md
        echo "Error, Primary key must be unique please enter another value"
        continue
    fi
    
    # Check Data type
    # change the data in the row
    if [[ "${col_type}" == "int" && "${ip_value}" =~ ^[0-9]+$ ]]; then
        rows=$(awk -F ":" -v pk=${pk_column_no} -v chk=${row_no} -v col=${col_no} \
        -v ipval=${ip_value} 'BEGIN {OFS=":"} {
            if ($pk != chk) {
                print $0
            }
            else {
                $col = ipval
                print $0
            }
                }' ${tablename})
        break

    # change the data in the row
    elif [[ "${col_type}" == "str" && "${ip_value}" =~ ^[a-zA-Z0-9@' '_.]+$ ]]; then
        rows=$(awk -F ":" -v pk=${pk_column_no} -v chk=${row_no} -v col=${col_no} \
        -v ipval=${ip_value} 'BEGIN {OFS=":"} {
            if ($pk != chk) {
                print $0
            }
            else {
                $col = ipval
                print $0
            }
                }' ${tablename})
        break

    else
        tput setaf 1 md
        echo "Input '${ip_value}' doesn't match the data type '${col_type}' for column '${col_name}', please try again"
        continue
    fi
done

echo "${rows}" > "${tablename}"
tput setaf 2 md
echo "Table ${tablename} has been updated successfully"
IFS="${oldifs}"
