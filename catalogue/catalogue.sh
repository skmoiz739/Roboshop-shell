component=catalogue
source common.sh
echo -e "${color} downloading nodejs ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/log.file
echo -e "${color} installing nodejs ${nocolor}"
yum install nodejs -y &>> /tmp/log.file

echo -e "${color} adding user ${nocolor}"
useradd roboshop &>> /tmp/log.file
echo -e "${color} creating dir ${nocolor}"
mkdir /app &>> /tmp/log.file
echo -e "${color} downloading ${component} files ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> /tmp/log.file
echo -e "${color} unzip ${nocolor}"
cd /app &>> /tmp/log.file
unzip /tmp/${component}.zip &>> /tmp/log.file
echo -e "${color} downloading dependencies ${nocolor}"
cd /app &>> /tmp/log.file
npm install &>> /tmp/log.file
echo -e "${color} system files ${nocolor}"
cp /home/centos/Roboshop-shell/${component}/${component}.service /etc/systemd/system/${component}.service &>> /tmp/log.file
echo -e "${color} schemas ${nocolor}"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/log.file
yum install mongodb-org-shell -y &>> /tmp/log.file
mongo --host mongodb-dev.devops-learning.site </app/schema/${component}.js &>> /tmp/log.file
echo -e "${color} starting ${component} ${nocolor}"
systemctl daemon-reload &>> /tmp/log.file
systemctl enable ${component} &>> /tmp/log.file
systemctl start ${component} &>> /tmp/log.file