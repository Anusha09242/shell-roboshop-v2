#!/bin/bash

app_name=shipping
MYSQL_HOST=mysql.anu90.shop
source ./common.sh
check_root

app_setup
java_setup

systemd_setup

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing MySQL client"

mysql -h mysql.anu90.shop -u root -pRoboShop@1 -e "use cities" &>> $LOGS_FILE
if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql 
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql
    VALIDATE $? "Data loaded"
else
    echo -e "Data already loaded... $Y SKIPPING $N"
fi

app_restart
print_total_time