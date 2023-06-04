source common.sh

echo -e "${color} copying repo files ${nocolor}"
cp /home/centos/Roboshop-shell/mongodb/mongodb.repo /etc/yum.repos.d/mongodb.repo &>> ${log_file}
stat_check $?

echo -e "${color} installing mongodb ${nocolor}"
yum install mongodb-org -y &>> ${log_file}
stat_check $?

echo -e "${color} editing address ${nocolor}"
sed -i "s/127.00.1/0.0.0.0/" /etc/mongod.conf &>> ${log_file}
stat_check $?

echo -e "${color} starting mongodb ${nocolor}"
systemctl enable mongod &>> ${log_file}
systemctl start mongod &>> ${log_file}
stat_check $?
