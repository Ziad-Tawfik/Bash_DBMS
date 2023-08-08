#!/bin/bash

echo -e "\nList of current DBs"
echo -e "##################\n"
if [[ $(ls | wc -l) -gt 0 ]]; then
    echo "$(ls)"
else
    echo -e "\nNo Databases exist, please create one"
fi
echo -e "\n##################\n"