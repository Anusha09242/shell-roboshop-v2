#!/bin/bash

app_name=payment
MYSQL_HOST=mysql.anu90.shop
source ./common.sh
check_root
app_setup
python_setup
systemd_setup
app_restart
print_total_time