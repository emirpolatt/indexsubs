#!/bin/bash

FILE="/home/espvuln/Desktop/splunk/index.html"
SUBS="/home/espvuln/Desktop/splunk/subs.txt"

printf "Pls Enter Hostname ( For example: google.com ) \n >>"
read site


getIndex () {
	wget $site
}

readSubs () {
    cat index.html | grep -Eo '([-[:alnum:]]+.)*'$site index.html | sort -u | sed  '/^etc/d;/^content/d;/login.splunk.com$/d;/^w/d' | tee subs.txt
}

getIp () {
    while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
	echo "Checking $LINE"
	resolveip -s $LINE | sort -u
    done < "$SUBS"
}

if [ -f "$FILE" ]; then
    readSubs
    getIp
else
    getIndex
    echo -e "\e[31mI pulled the index.html file. Pls again run this script"
fi
