component=user
source common.sh
nodejs
echo -e "\e[33m loading schemas \e[0m"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/log.file
yum install mongodb-org-shell -y &>> /tmp/log.file&>> /tmp/log.file
mongo --host mongodb-dev.devops-learning.site </app/schema/user.js &>> /tmp/log.file