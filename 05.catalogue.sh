#!/bin/bash

app_name=catalogue
source ./common.sh
check_root
app_setup
nodejs_setup
systemd_setup

cp $SCRPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Added mongo repo"

dnf install mongodb-mongosh -y &>> $LOGS_FILE
VALIDATE $? "Installed MongoDB Client"

INDEX=$(mongosh --host mongodb.anu90.shop --eval 'db.getMongo().getDBNames().indexOf("catalogue")')

if [ $INDEX -lt 0 ]; then
    mongosh --host mongodb.anu90.shop </app/db/master-data.js &>> $LOGS_FILE
    VALIDATE $? "Load Products"
else
    echo -e "Products already loaded... $Y SKIPPING $N"
fi

app_restart

print_total_time