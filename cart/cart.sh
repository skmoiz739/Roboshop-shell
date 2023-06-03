echo -e "\e[33m downloading nginx \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/log.file
echo -e "\e[33m installing nginx \e[0m"
yum install nodejs -y &>> /tmp/log.file
echo -e "\e[33m adding user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m creating dir \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m download and unzip \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>> /tmp/log.file
cd /app
unzip /tmp/cart.zip &>> /tmp/log.file
echo -e "\e[33m installing dependencies \e[0m"
cd /app
npm install &>> /tmp/log.file
echo -e "\e[33m installing service files \e[0m"
cd /home/centos/Roboshop-shell/cart/cart.service  /ect/systemd/system/cart.service &>> /tmp/log.file
echo -e "\e[33m starting nginx \e[0m"
systemctl daemon-reload &>> /tmp/log.file
systemctl enable cart  &>> /tmp/log.file
systemctl start cart &>> /tmp/log.file

