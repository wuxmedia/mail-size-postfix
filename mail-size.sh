#!/bin/bash
#tdh@positive-internet.com
MAILPATH=/var/lib/vmail/

# grab absolute path email domains
DOM=$(find "$MAILPATH" -maxdepth 1 -mindepth 1 -type d)

#grab users from each domain
USER=$(find $DOM -maxdepth 1 -mindepth 1 -type d)

#get users more than 14G
LIST=$(du -sh --threshold=15G $USER)

#go through them and make an email address out of it
EMAIL=$(for i in $(echo "$LIST" ) ; do echo $i | grep -v [0-9]G | awk -F "/" '{ print $6"@"$5}'; done)         
