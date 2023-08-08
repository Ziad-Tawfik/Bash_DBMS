#!/bin/bash

echo -e "\nList of current tables in ${dbname}"
echo -e "##################\n"
if [[ $(ls | wc -l) -gt 0 ]]; then
    echo "$(ls -1)"
else
    echo -e "No tables exist, please create one"
fi
echo -e "\n##################\n"