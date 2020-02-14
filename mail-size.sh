#!/bin/bash
#TDH wuxmedia@gmail.com
### testmail
EMAIL=tdh@positive-internet.com

FIND="ionice -c3 $(which find)"
DU="ionice -c3 $(which du)"
MAILPATH=/var/lib/vmail/
SENDMAIL=$(which sendmail)
FROM=admin@example.com

# grab absolute path email domains
DOM=$($FIND "$MAILPATH" -maxdepth 1 -mindepth 1 -type d)

#grab users from each domain
USERPATH=$($FIND $DOM -maxdepth 1 -mindepth 1 -type d)

#get users more than 14G
#LIST=$($DU -sh --threshold=15G $USERPATH)

#go through them and make an email address out of it
#EMAIL_LIST=$(for i in $(echo "$LIST" ) ; do echo $i | grep -v [0-9]G | awk -F "/" '{ print $6"@"$5}'; done)

#loop through that list and send off a mail for each
for EMAIL in $EMAIL_LIST
  do
SUBJECT="Attention: Your mailbox size is too damn high"
BODY="
From: $FROM
To: $EMAIL
Cc: $FROM
Reply-To: $FROM

Dear $EMAIL,

The volume of your mailbox is approaching the maximum.
Please apply the email archiving standard procedure as soon as possible.
Do not hesitate to contact me if you need help applying this procedure.
Let me know when archiving is completed and I will perform the backup.

Thanks,
Admin Team

"

#send it all off
echo "Subject: $SUBJECT" "$BODY" | $SENDMAIL -f $FROM -t
done
