echo -e "\e[33m downloading vendor package \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>> /tmp/log/file
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> /tmp/log/file
echo -e "\e[33m installing rabbitmq server \e[0m"
yum install rabbitmq-server -y  &>> /tmp/log/file
echo -e "\e[33m start and enable server \e[0m"
systemctl enable rabbitmq-server  &>> /tmp/log/file
systemctl start rabbitmq-server  &>> /tmp/log/file
echo -e "\e[33m adding user nd password \e[0m"
rabbitmqctl add_user roboshop roboshop123  &>> /tmp/log/file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>> /tmp/log/file