#!/bin/bash
adminUsername=$1
adminpassword=$2
orguser=$3
Firstname=$4
Lastname=$5
mailid=$6
mkdir /home/chefpemfiles
chef-marketplace-ctl upgrade -y
sudo chef-server-ctl reconfigure
automate-ctl create-user default $1 --password $2
chmod 755 /root/chefpemfiles
chef-server-ctl user-create $1 $4 $5 $6 $2 > /home/chefpemfiles/$1.pem
chef-server-ctl org-create $3 "sysg organisation" -a $1 > /home/chefpemfiles/$3-validator.pem