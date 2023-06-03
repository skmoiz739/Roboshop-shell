component=catalogue
source common.sh
nodejs

echo -e "${color} copy mongo repo file and install Mongod client ${nocolor}"
cp /home/centos/Roboshop-shell//mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> ${log_file}
yum install mongodb-org-shell -y &>> ${log_file}

echo -e "${color} schemas ${nocolor}"
mongo --host mongodb-dev.devops-learning.site <${app_path}/schema/${component}.js &>> ${log_file}
