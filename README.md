# Encryption Tools
This includes some security scripts for passing around information in a more secure manner

## Encrypt Text
Encrypt plain text, send decryption command one way, send key another way. 

The command is as follows:
```
$ ./path/to/encrypt-decrypt-text.sh
Enter string to encrypt: <paste hidden plain text here>
```

This will output two portions:
```
Shared Secret (send via [encrypted optionally] email):
<some-big-secret-string-here>
```

and
```
Decryption Command (send via slack):
echo "U2FsdGVkX1+6vmWAvc/mlx3wEMaM/qI2ttUeEX8gJg4=" | openssl enc -aes-256-cbc -a -d
```


## Encrypt File
This will encrypt all file contents and [optionally] zip it, following a similar pattern:

Enclosed is a folder `./assets/`. To encrypt, copy the file to the `/assets/` folder and copy the name of the file to the clipboard. Then run:

```
$ ./path/to/encrypt-decrypt-file.sh [-z]

Copy File to encrypt into /some/path/security-scripts/assets/
Enter file to encrypt : /some/path/security-scripts/assets/<paste-filename-here>
```

The output will look similar:
```
Shared Secret (send via email):
<some-big-secret-string-here>

Decryption Command (send with .enc file via slack or second email):
openssl enc -aes-256-cbc -d -a -in ./assets/demo-text-file.rtf.zip.enc -out ./assets/demo-text-file.rtf.zip; unzip ./assets/demo-text-file.rtf.zip && rm ./assets/demo-text-file.rtf.zip
```

The receiver will run those to decrypt with the associated shared secret.