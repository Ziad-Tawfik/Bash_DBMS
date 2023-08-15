#!/bin/bash
tput setaf 3 md
echo -e "\nList of current DBs"
echo -e "##################"
if [[ $(ls | wc -l) -gt 0 ]]; then
    tput setaf 2 md
    echo "$(ls)"
else
    tput setaf 1 md
    echo -e "No Databases exist, please create one first"
fi
tput setaf 3 md
echo -e "##################"