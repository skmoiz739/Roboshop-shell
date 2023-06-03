color="\e[33m"
nocolr="\e[0m"
log_file="/tmp/log.file"
app_path="/app"

nodejs() {
 echo -e "${color} configuring nodejs repos  ${nocolor}"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}
 echo -e "${color} installing nodejs ${nocolor}"
 yum install nodejs -y &>> ${log_file}
 echo -e "${color} adding user ${nocolor}"
 useradd roboshop &>> ${log_file}
 echo -e "${color} creating dir ${nocolor}"
 mkdir ${app_path} &>> ${log_file}
 echo -e "${color} downloading application content ${nocolor}"
 curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}
 echo -e "${color} unzip and extracting files ${nocolor}"
 cd ${app_path} &>> ${log_file}
 unzip /tmp/${component}.zip &>> ${log_file}
 echo -e "${color} downloading nodejs dependencies ${nocolor}"
 cd ${app_path} &>> ${log_file}
 npm install &>> ${log_file}
 echo -e "${color} settingup systemd service ${nocolor}"
 cp /home/centos/Roboshop-shell/${component}/${component}.service /etc/systemd/system/${component}.service &>> ${log_file}
 echo -e "${color} starting ${component} service ${nocolor}"
 systemctl daemon-reload &>> ${log_file}
 systemctl enable ${component} &>> ${log_file}
 systemctl start ${component} &>> ${log_file}
 }

schema_setup() {
  echo -e "${color} copy mongo repo file ${nocolor}"
  cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> ${log_file}
  echo -e "${color}  install Mongod client ${nocolor}"
  yum install mongodb-org-shell -y &>> ${log_file}

  echo -e "${color} load schemas ${nocolor}"
  mongo --host mongodb-dev.devops-learning.site <${app_path}/schema/${component}.js &>> ${log_file}
}

