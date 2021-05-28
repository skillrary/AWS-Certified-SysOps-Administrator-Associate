#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
aws s3 cp s3://skillrary-lab-bapei-elb/names.csv ./
aws s3 cp s3://skillrary-lab-bapei-elb/index.txt ./
EC2NAME=`cat ./names.csv|sort -R|head -n 1|xargs`
sed "s/INSTANCEID/$EC2NAME/" index.txt > index.html
