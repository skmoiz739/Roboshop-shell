source common.sh

echo -e "${nocolor} disabling current mysql verison ${nocolor}"
yum module disable mysql -y &>> ${log_file}
stat_check $?

echo -e "${nocolor} copy mysql repo ${nocolor}"
cp cp /home/centos/Roboshop-shell/mysql/mysql.repo  /etc/yum.repos.d/mysql.repo  &>> ${log_file}
stat_check $?

echo -e "${nocolor} install mysql  ${nocolor}"
yum install mysql-community-server -y  &>> ${log_file}
stat_check $?

echo -e "${nocolor} start mysql ${nocolor}"
systemctl enable mysqld  &>> ${log_file}
systemctl start mysqld  &>> ${log_file}
stat_check $?

echo -e "${nocolor} set user password ${nocolor}"
mysql_secure_installation --set-root-pass $1  &>> ${log_file}
stat_check $?