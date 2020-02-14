#!/bin/bash
#tdh@positive-internet.com
### testmail
#EMAIL=tdh@positive-internet.com

FIND="ionice -c3 $(which find)"
DU="ionice -c3 $(which du)"
MAILPATH=/var/lib/vmail/
SENDMAIL=$(which sendmail)
FROM=admin@example.com
SUBJECT="Email archiving needed"
BODY="
From: $FROM
To: $EMAIL
Cc: $FROM

Dear $EMAIL,

The volume of your mailbox is approaching the maximum.
Please apply the email archiving standard procedure as soon as possible.
Do not hesitate to contact me if you need help applying this procedure.
Let me know when archiving is completed and I will perform the backup.

Yours, 
$FROM
"

# grab absolute path email domains
DOM=$($FIND "$MAILPATH" -maxdepth 1 -mindepth 1 -type d)

#grab users from each domain
USERPATH=$($FIND $DOM -maxdepth 1 -mindepth 1 -type d)

#get users more than 15G
LIST=$($DU -sh --threshold=15G $USERPATH)

#go through them and make an email address out of it
EMAIL=$(for i in $(echo "$LIST" ) ; do echo $i | grep -v [0-9]G | awk -F "/" '{ print $6"@"$5}'; done)

#send it all off
echo "Subject: $SUBJECT" "$BODY" | $SENDMAIL -t
