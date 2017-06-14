#!/bin/bash
adminUsername=$1
adminpassword=$2
orguser=$3
Firstname=$4
Lastname=$5
mailid=$6
fqdn=$7
chef-marketplace-ctl upgrade -y
sudo chef-server-ctl reconfigure
automate-ctl create-user default $1 --password $2
##pull files from repo  
wget https://trendmicrop2p.blob.core.windows.net/trendmicropushtopilot/files/validatorkey.txt  -O /tmp/validatorkey.txt
wget https://trendmicrop2p.blob.core.windows.net/trendmicropushtopilot/files/userkey.txt -O /tmp/userkey.txt
##Assigning variable to construct and update key and key-value
validatorkey=`cat /tmp/validatorkey.txt`
userkey=`cat /tmp/userkey.txt`
sudo chef-server-ctl user-create $1 $4 $5 $6 $2 > /etc/opscode/$1.pem
sudo chef-server-ctl org-create $3 "sysg organisation" -a $1 > /etc/opscode/$3-validator.pem
#Upload key value.
FINAL="\"}' "$7
echo $validatorkey`cat /etc/opscode/${3}-validator.pem | base64 | tr -d '\n'`$FINAL| bash
echo $userkey`cat /etc/opscode/${1}.pem | base64 | tr -d '\n'`$FINAL | bash
