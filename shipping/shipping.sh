echo -e "\e[33m installing python \e[0m"
yum install maven -y &>> /tmp/log.file
echo -e "\e[33m add user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m create dir \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m download and unzip python \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> /tmp/log.file
cd /app
unzip /tmp/shipping.zip &>> /tmp/log.file
echo -e "\e[33m downloading dependencies \e[0m"
cd /app
mvn clean package &>> /tmp/log.file
mv target/shipping-1.0.jar shipping.jar &>> /tmp/log.file

echo -e "\e[33m copy system files \e[0m"
cd /home/centos/Roboshop-shell/shipping/shipping.service  \ect/systemd/system/shipping.service &>> /tmp/log.file
echo -e "\e[33m installing mysql schema \e[0m"
yum install mysql -y &>> /tmp/log.file
mysql -h mysql-dev.devops-learning.site -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> /tmp/log.file
echo -e "\e[33m reload system \e[0m"
systemctl daemon-reload &>> /tmp/log.file
echo -e "\e[33m enable and start \e[0m"
systemctl enable shipping &>> /tmp/log.file
systemctl start shipping &>> /tmp/log.file