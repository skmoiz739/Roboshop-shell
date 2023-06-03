echo -e "\e[33m copying repo files \e[0m"
cp /home/centos/Roboshop-shell/mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/log.file
echo -e "\e[33m installing mongodb \e[0m"
yum install mongodb-org -y &>> /tmp/log.file
echo -e "\e[33m editing address \e[0m"
sed -i "s/127.00.1/0.0.0.0/" /etc/mongod.conf &>> /tmp/log.file
echo -e "\e[33m starting mongodb \e[0m"
systemctl enable mongod &>> /tmp/log.file
systemctl start mongod &>> /tmp/log.file

