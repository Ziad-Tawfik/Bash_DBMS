#!/bin/bash

echo -e "\nList of current DBs"
echo "##################"
if [[ $(ls | wc -l) -gt 0 ]]; then
    echo "$(ls)"
else
    echo "\nNo Databases exist, please create one"
fi
echo -e "##################\n"