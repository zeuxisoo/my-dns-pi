#!/bin/bash

# PASSWORD="YOUR_PASSWORD_HERE";
echo -n Password:
read -s password
echo

echo -n $password | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4
