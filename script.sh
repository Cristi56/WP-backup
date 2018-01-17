#!/bin/bash

echo "Site name"
read SITE_NAME



NOW=$(date +"%Y-%m-%d-%H_%M")
FILE="$WPDBNAME-$NOW.sql"
BACKUP_DIR="/opt/"
#SITE_DIR='find / -name "$SITE_NAME"'
PWD=pwd

WPDBNAME=`grep DB_NAME $SITE_NAME/wp-config.php | cut -d \' -f 4`
WPDBUSER=`grep DB_USER $SITE_NAME/wp-config.php | cut -d \' -f 4`
WPDBPASS=`grep DB_PASSWORD $SITE_NAME/wp-config.php | cut -d \' -f 4`
HOST_PORT=`grep DB_HOST $SITE_NAME/wp-config.php | cut -d \' -f 4`

if [ $HOST_PORT == "('DB_HOST', 'localhost')" ]
	then
mysqldump --user=$WPDBUSER --password=$WPDBPASS $WPDBNAME > $WPDBNAME.$NOW.sql
	else	
mysqldump --user=$WPDBUSER --password=$WPDBPASS --host=$HOST_PORT $WPDBNAME > $WPDBNAME.$NOW.sql
fi

tar -cvf $SITE_NAME.$NOW.tar $SITE_NAME 


tar -xvf $SITE_NAME $SITE_NAME.$NOW.tar
mysqldump --user=$WPDBUSER --password=$WPDBPASS $WPDBNAME < $WPDBNAME.$NOW.sql
