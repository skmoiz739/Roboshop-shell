color="\e[33m"
nocolr="\e[0m"
log_file="${/tmp/log.file}"
app_path="/app"
user_id=$(id -u)
if [$user_id -ne 0]; then
  echo script shouldbe running as root user
  exit1
fi

stat_check() {
  if [ $1 -eq 0 ]; then
    echo sucess
  else
    echo failure
    exit 1
  fi
}

app_setup() {

    echo -e "${color} adding user ${nocolor}"
    id roboshop  &>> ${log_file}
    if [ $? eq 1 ]; then
     useradd roboshop &>> ${log_file}
    fi

    stat_check $?

    echo -e "${color} creating dir ${nocolor}"
    rm -rf ${app_path} &>> ${log_file}
    mkdir ${app_path} &>> ${log_file}
    stat_check $?

    echo -e "${color} downloading application content ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log_file}

    stat_check $?

    echo -e "${color} unzip and extracting files ${nocolor}"
    cd ${app_path} &>> ${log_file}
    unzip /tmp/${component}.zip &>> ${log_file}

    stat_check $?
}

systemd_setup() {

   echo -e "${color} settingup systemd service ${nocolor}"
   cp /home/centos/Roboshop-shell/${component}/${component}.service /etc/systemd/system/${component}.service &>> ${log_file}
   sed-i -e"s/roboshop_app_password/$1/"  /etc/systemd/system/${component}.service

   stat_check $?

   echo -e "${color} starting ${component} service ${nocolor}"
   systemctl daemon-reload &>> ${log_file}
   systemctl enable ${component} &>> ${log_file}
   systemctl start ${component} &>> ${log_file}

   stat_check $?
}



nodejs() {
 echo -e "${color} configuring nodejs repos  ${nocolor}"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}
 stat_check $?

 echo -e "${color} installing nodejs ${nocolor}"
 yum install nodejs -y &>> ${log_file}
 stat_check $?

 app_setup

 echo -e "${color} downloading nodejs dependencies ${nocolor}"
 npm install &>> ${log_file}
 stat_check $?

 systemd_setup

 }


mysql_schema_setup() {
   echo -e "${color} installing mysql client and loading schema ${nocolor}"
   yum install mysql -y &>> ${log_file}
   stat_check $?

   mysql -h mysql-dev.devops-learning.site -uroot -p${mysql_root_password} < ${app_path}/schema/${component}.sql &>> ${log_file}
   stat_check $?
}


mongo_schema_setup() {
  echo -e "${color} copy mongo repo file ${nocolor}"
  cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> ${log_file}
  stat_check $?

  echo -e "${color}  install Mongod client ${nocolor}"
  yum install mongodb-org-shell -y &>> ${log_file}
  stat_check $?

  echo -e "${color} load schemas ${nocolor}"
  mongo --host mongodb-dev.devops-learning.site <${app_path}/schema/${component}.js &>> ${log_file}
  stat_check $?
}

maven() {
  echo -e "${color} installing python ${nocolor}"
  yum install maven -y &>> ${log_file}
  stat_check $?

  app_setup

  echo -e "${color} downloading dependencies ${nocolor}"
  cd ${app_path}
  mvn clean package &>> ${log_file}
  mv target/${component}-1.0.jar ${component}.jar &>> ${log_file}
  stat_check $?

  mysql_schema_setup

  systemd_setup

}

python() {
  echo -e "${color} install python ${nocolor}"
  yum install python36 gcc python3-devel -y &>> ${log_file}

  stat_check $?

  app_setup

  echo -e "${color} download dependencies ${nocolor}"
  cd app_path
  pip3.6 install -r requirements.txt &>> ${log_file}

  stat_check $?

  systemd_setup

}

