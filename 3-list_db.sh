#!/bin/bash

echo "List of current DBs"
echo "##################"
if [[ $(ls | wc -l) -gt 0 ]]; then
    echo "$(ls)"
else
    echo "No Databases exist, please create one"
fi
echo "##################"