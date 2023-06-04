echo -e "\e[33m disabling current mysql verison \e[0m"
yum module disable mysql -y &>> /tmp/log.file
echo -e "\e[33m copy mysql repo \e[0m"
cp cp /home/centos/Roboshop-shell/mysql/mysql.repo  /etc/yum.repos.d/mysql.repo  &>> /tmp/log.file
echo -e "\e[33m install mysql  \e[0m"
yum install mysql-community-server -y  &>> /tmp/log.file
echo -e "\e[33m start mysql \e[0m"
systemctl enable mysqld  &>> /tmp/log.file
systemctl start mysqld  &>> /tmp/log.file
echo -e "\e[33m set user password \e[0m"
mysql_secure_installation --set-root-pass $1  &>> /tmp/log.file
