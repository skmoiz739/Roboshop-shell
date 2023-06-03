component=cart
source common.sh
echo -e "${color} downloading nginx ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}
echo -e "${color} installing nginx ${nocolor}"
yum install nodejs -y &>> ${log_file}
echo -e "${color} adding user ${nocolor}"
useradd roboshop &>> ${log_file}
echo -e "${color} creating dir ${nocolor}"
mkdir ${app_path} &>> ${log_file}
echo -e "${color} download and unzip ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
cd ${app_path}
unzip /tmp/${component}.zip &>> ${log_file}
echo -e "${color} installing dependencies ${nocolor}"
cd ${app_path}
npm install &>> ${log_file}
echo -e "${color} installing service files ${nocolor}"
cd /home/centos/Roboshop-shell/${component}/${component}.service  /ect/systemd/system/${component}.service &>> ${log_file}
echo -e "${color} starting nginx ${nocolor}"
systemctl daemon-reload &>> ${log_file}
systemctl enable ${component}  &>> ${log_file}
systemctl start ${component} &>> ${log_file}

