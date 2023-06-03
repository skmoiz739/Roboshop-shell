echo -e "\e[33m install python \e[0m"
yum install python36 gcc python3-devel -y &>> /tmp/log.file
echo -e "\e[33madd user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m create dir \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m downlaod and extract the content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> /tmp/log.file
cd /app
unzip /tmp/payment.zip &>> /tmp/log.file
echo -e "\e[33m download dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt &>> /tmp/log.file
echo -e "\e[33m copy service file \e[0m"
cp /home/centos/Roboshop-shell/payment/payment.service  /etc/systemd/system/payment.service &>> /tmp/log.file
echo -e "\e[33m reload system \e[0m"
systemctl daemon-reload &>> /tmp/log.file
echo -e "\e[33m enable and start \e[0m"
systemctl enable payment &>> /tmp/log.file
systemctl start payment &>> /tmp/log.file