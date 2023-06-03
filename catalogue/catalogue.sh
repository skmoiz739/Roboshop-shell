component=catalogue
source common.sh
echo -e "${color} downloading nodejs ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}
echo -e "${color} installing nodejs ${nocolor}"
yum install nodejs -y &>> ${log_file}

echo -e "${color} adding user ${nocolor}"
useradd roboshop &>> ${log_file}
echo -e "${color} creating dir ${nocolor}"
mkdir /app &>> ${log_file}
echo -e "${color} downloading ${component} files ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
echo -e "${color} unzip ${nocolor}"
cd /app &>> ${log_file}
unzip /tmp/${component}.zip &>> ${log_file}
echo -e "${color} downloading dependencies ${nocolor}"
cd /app &>> ${log_file}
npm install &>> ${log_file}
echo -e "${color} system files ${nocolor}"
cp /home/centos/Roboshop-shell/${component}/${component}.service /etc/systemd/system/${component}.service &>> ${log_file}
echo -e "${color} schemas ${nocolor}"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> ${log_file}
yum install mongodb-org-shell -y &>> ${log_file}
mongo --host mongodb-dev.devops-learning.site </app/schema/${component}.js &>> ${log_file}
echo -e "${color} starting ${component} ${nocolor}"
systemctl daemon-reload &>> ${log_file}
systemctl enable ${component} &>> ${log_file}
systemctl start ${component} &>> ${log_file}