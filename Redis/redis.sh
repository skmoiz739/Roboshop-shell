echo -e "\e[33m installing redis server \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/log.file
echo -e "\e[33m enable redis server module \e[0m"
yum module enable redis:remi-6.2 -y &>> /tmp/log.file
echo -e "\e[33m installing redis server \e[0m"
yum install redis -y &>> /tmp/log.file
echo -e "\e[33m updating ip adress \e[0m"
sed -i "s/127.0.0.1/0.0.0.0" /etc/redis.conf &>> /tmp/log.file
echo -e "\e[33m starting redis server \e[0m"
systemctl enable redis &>> /tmp/log.file
systemctl start redis &>> /tmp/log.file