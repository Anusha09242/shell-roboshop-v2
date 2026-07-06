#!/bin/bash

app_name=payment
source ./common.sh
check_root

dnf install python3 gcc python3-devel -y &>> $LOGS_FILE
VALIDATE $? "Installing Maven"

app_setup

pip3 install -r requirements.txt &>> $LOGS_FILE
VALIDATE $? "Installing dependencies"

systemd_setup

app_restart
print_total_time