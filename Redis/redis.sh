source common.sh

echo -e "${color} installing redis server ${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${log_file}
stat_check $?

echo -e "${color} enable redis server module ${nocolor}"
yum module enable redis:remi-6.2 -y &>> ${log_file}
stat_check $?

echo -e "${color} installing redis server ${nocolor}"
yum install redis -y &>> ${log_file}
stat_check $?

echo -e "${color} updating ip adress ${nocolor}"
sed -i "s/127.0.0.1/0.0.0.0" /etc/redis.conf /etc/redis/redis.conf &>> ${log_file}
stat_check $?

echo -e "${color} starting redis server ${nocolor}"
systemctl enable redis &>> ${log_file}
systemctl start redis &>> ${log_file}
stat_check $?