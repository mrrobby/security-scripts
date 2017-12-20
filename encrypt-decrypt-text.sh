#!/bin/bash

# generate shared secret
shared_secret=$(openssl rand -hex 30)

# get string to encrypt from user
read -s -p "Enter string to encrypt: " secret

# encrypt string
encrypted_string=$(echo "$secret" | openssl enc -aes-256-cbc -a -pass pass:$shared_secret)
cmd="echo \"$encrypted_string\" | openssl enc -aes-256-cbc -a -d"

# print shared secret and decrypt command
printf "\n\nShared Secret (send via email):\n$shared_secret\n"
printf "\nDecryption Command (send via slack):\n$cmd\n\n"