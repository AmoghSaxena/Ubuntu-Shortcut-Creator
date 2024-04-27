#!/bin/bash


## RUN THIS AS A ROOT USER
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

### TO FIND THE PATH OF LOCATION
TMPE=$( realpath "$0"  )
cd $(dirname "$TMPE")

## GETING THE PYTHON LOCATION
PYLOC=$(which python3)
if [[ -n "$PYLOC" ]]; then
    echo "Python3 Found"
    echo '#!'$PYLOC > /usr/local/bin/pyusc
    cat set_customshortcut.py >> /usr/local/bin/pyusc
else
    echo "Please install python3"
    exit
fi

## GIVING EXECUTABLE PERMISSION TO THE FILE
chmod +x /usr/local/bin/pyusc
echo "INSTALLATION COMPLETE!!!"