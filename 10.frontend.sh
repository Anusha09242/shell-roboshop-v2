#!/bin/bash

app_name=frontend
source ./common.sh
check_root

dnf module disable nginx -y &>> $LOGS_FILE
dnf module enable nginx:1.24 -y &>> $LOGS_FILE
dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? "Installing Nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "Removed Default code"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip  &>> $LOGS_FILE
cd /usr/share/nginx/html  &>> $LOGS_FILE
unzip /tmp/frontend.zip &>> $LOGS_FILE
VALIDATE $? "Downloaded and Extracted frontend code"

rm -f /etc/nginx/nginx.conf
VALIDATE $? "Removed Default conf"

cp $SCRPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Copied roboshop nginx conf"

systemctl restart nginx 
systemctl enable nginx &>> $LOGS_FILE
VALIDATE $? "Enabled and Restarted nginx"

print_total_time