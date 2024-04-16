#!/bin/bash

echo "This script is used to create a user on an existing machine."
read -p "Enter user name: " user_id

echo "Checking whether user is available to create or not."
output=$(id "$user_id" 2>/dev/null | awk -F '[()]' '{ print $2 }')

if [ "$output" == "$user_id" ]; then
    echo "Provided user already exists on the machine."
    id "$user_id"
else
    echo "User available to create."
    echo " ###################################"
    useradd "$user_id"
    echo " please type y if you want to set password or else enter N for none password "
    read -p "enter option "y" or "n" : " pass_id

    if [ "$pass_id" == "y" ] || [ "$pass_id" == "Y" ]; then
        echo " plese enter password for your ID "
        passwd $user_id
        echo " password has been updated"
    else
        echo " password not set for $user_id"
    fi
fi
