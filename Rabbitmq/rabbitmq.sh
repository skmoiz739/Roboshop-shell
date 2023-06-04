source common.sh

echo -e "${nocolor} downloading vendor package ${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>> ${log_file}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> ${log_file}
stat_check $?

echo -e "${nocolor} installing rabbitmq server ${nocolor}"
yum install rabbitmq-server -y  &>> ${log_file}
stat_check $?

echo -e "${nocolor} start and enable server ${nocolor}"
systemctl enable rabbitmq-server  &>> ${log_file}
systemctl start rabbitmq-server  &>> ${log_file}
stat_check $?

echo -e "${nocolor} adding user nd password ${nocolor}"
rabbitmqctl add_user roboshop $1  &>> ${log_file}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>> ${log_file}
stat_check $?