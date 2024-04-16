#!/bin/bash

echo "Script started working..."
echo "Updating the package list..."
apt update >/dev/null 2>&1

if [ $? == 0 ]; then
    echo "Package list updated successfully."
    echo "Checking memory size of the system..."
    memory_size=$(free -h 2>/dev/null | awk 'NR==2 {print $7}' | sed 's/[^0-9]//g')

    echo "Checking available storage..."
    if [ $memory_size -gt 500 ]; then
        echo "We can install ansible on this machine. Available storage is $memory_size."

        echo "Installing python3..."
        apt install -y python3 >/dev/null 2>&1

        if [ $? == 0 ]; then
            echo "Python3 installed successfully."
            echo "Installing ansible..."
            apt install -y ansible >/dev/null 2>&1

            if [ $? == 0 ]; then
                echo "Ansible installed successfully."
                echo "Creating ansible config file..."
                touch /root/.ansible/ansible.config

                echo "Script completed 100%."
            else
                echo "Failed to install ansible."
            fi
        else
            echo "Failed to install python3."
        fi
    else
        echo "Not enough memory to install ansible."
    fi
else
    echo "Failed to update package list."
fi
