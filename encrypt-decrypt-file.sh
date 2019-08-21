#!/bin/bash

# generate shared secret
shared_secret=$(openssl rand -hex 30)

# get string to encrypt from user
printf "\n\nCopy File to encrypt into `pwd`/assets/\n"
read -p "Enter file to encrypt : `pwd`/assets/" filename

# optionally, zip first then encrypt...might not work
while getopts "z" option; do
 case "${option}" in
 	z ) filepath="./assets/${filename}"; zip -r "${filepath}.zip" ${filepath}; filepath="${filepath}.zip"; filename="${filename}.zip"
			# encrypt file
			openssl enc -aes-256-cbc -salt -a -pass pass:$shared_secret -in ${filepath} -out ${filepath}.enc
			cmd="openssl enc -aes-256-cbc -d -a -in ${filepath}.enc -out ${filepath}; unzip ${filepath} && rm ${filepath}"
			rm -f "${filepath}"
		 ;;
	: ) filepath="./assets/${filename}"
			# encrypt file
			openssl enc -aes-256-cbc -salt -a -pass pass:$shared_secret -in ${filepath} -out ${filepath}.enc
			cmd="openssl enc -aes-256-cbc -d -a -in ${filepath}.enc -out ${filepath}"
		 ;;
	\? ) echo "Usage: cmd [-z]"
     ;;
 esac
done

# print shared secret and crypt command
printf "\n\nShared Secret (send via [encrypted optionally] email):\n$shared_secret\n"
printf "\nDecryption Command (send with .enc file via slack or second email):\n$cmd\n\n"