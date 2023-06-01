echo -e "\e[33m downloading nginx \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/log.file
echo -e "\e[33m installing nginx \e[0m"
yum install nodejs -y &>> /tmp/log.file
echo -e "\e[33m adding user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m creating dir  \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m downlaoding dependencies and unzipping \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/log.file
cd /app
unzip /tmp/user.zip &>> /tmp/log.file
cd /app
npm install &>> /tmp/log.file
echo -e "\e[33m settingup service files \e[0m"
cp /home/centos/Roboshop-shell/user/user.service /etc/systemd/system/user.service &>> /tmp/log.file
echo -e "\e[33m loading schemas \e[0m"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/log.file
yum install mongodb-org-shell -y &>> /tmp/log.file&>> /tmp/log.file
mongo --host mongodb-dev.devops-learning.site </app/schema/user.js &>> /tmp/log.file