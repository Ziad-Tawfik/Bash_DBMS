#!/bin/bash
tput setaf 3 md
echo -e "\nList of current tables in $(tput setaf 1 md) ${dbname}"
tput setaf 3 md
echo -e "##################"
if [[ $(ls | wc -l) -gt 0 ]]; then
    tput setaf 2 md
    echo "$(ls -1)"
else
    tput setaf 1 md
    echo -e "No tables exist, please create one"
fi
tput setaf 3 md
echo -e "##################"