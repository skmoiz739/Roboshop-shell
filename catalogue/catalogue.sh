echo -e "\e[33m downloading nodejs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/log.file
echo -e "\e[33m installing nodejs \e[0m"
yum install nodejs -y &>> /tmp/log.file

echo -e "\e[33m adding user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m creating dir \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m downloading catalogue files \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/log.file
echo -e "\e[33m unzip \e[0m"
cd /app &>> /tmp/log.file
unzip /tmp/catalogue.zip &>> /tmp/log.file
echo -e "\e[33m downloading dependencies \e[0m"
cd /app &>> /tmp/log.file
npm install &>> /tmp/log.file
echo -e "\e[33m system files \e[0m"
cp /home/centos/Roboshop-shell/catalogue/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/log.file
echo -e "\e[33m schemas \e[0m"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/log.file
yum install mongodb-org-shell -y &>> /tmp/log.file
mongo --host mongodb-dev.devops-learning.site </app/schema/catalogue.js &>> /tmp/log.file
echo -e "\e[33m starting catalogue \e[0m"
systemctl daemon-reload &>> /tmp/log.file
systemctl enable catalogue &>> /tmp/log.file
systemctl start catalogue &>> /tmp/log.file