#!/bin/bash

source ./common.sh

check_root

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Adding Rabbitmq Repo"

dnf install rabbitmq-server -y &>> $LOGS_FILE
VALIDATE $? "Installing Rabbitmq Server"

systemctl enable rabbitmq-server &>> $LOGS_FILE
systemctl start rabbitmq-server &>> $LOGS_FILE
VALIDATE $? "Enable and Start Rabbitmq Server"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGS_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGS_FILE
VALIDATE $? "Setting up the username and password"

print_total_time