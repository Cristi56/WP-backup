#!/bin/bash

echo "Site name"
read SITE_NAME

echo "which version"
read VERSION

tar -xvf $VERSION.tar $SITE_NAME


WPDBNAME=`grep DB_NAME $SITE_NAME/wp-config.php | cut -d \' -f 4`
WPDBUSER=`grep DB_USER $SITE_NAME/wp-config.php | cut -d \' -f 4`
WPDBPASS=`grep DB_PASSWORD $SITE_NAME/wp-config.php | cut -d \' -f 4`
HOST_PORT=`grep DB_HOST $SITE_NAME/wp-config.php | cut -d \' -f 4`




mysql -uroot -e "CREATE DATABASE $WPDBNAME"

if [ $HOST_PORT == "('DB_HOST', 'localhost')" ]
        then
mysql -p -u$WPDBUSER --password=$WPDBPASS $WPDBNAME < $VERSION.sql
        else
mysql -p -u$WPDBUSER --password=$WPDBPASS --host=$HOST_PORT $WPDBNAME < $VERSION.sql
fi
