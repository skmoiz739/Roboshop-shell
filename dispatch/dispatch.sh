echo -e "\e[33m installing golang \e[0m"
yum install golang -y &>> /tmp/log.file
echo -e "\e[33m add user \e[0m"
useradd roboshop &>> /tmp/log.file
echo -e "\e[33m create dir \e[0m"
mkdir /app &>> /tmp/log.file
echo -e "\e[33m download and extract the content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>> /tmp/log.file
cd /app
unzip /tmp/dispatch.zip &>> /tmp/log.file
echo -e "\e[33m download dependencies \e[0m"
cd /app
go mod init dispatch &>> /tmp/log.file
go get &>> /tmp/log.file
go build &>> /tmp/log.file
echo -e "\e[33m daemon-reload \e[0m"
systemctl daemon-reload &>> /tmp/log.file
echo -e "\e[33m enable and start \e[0m"
systemctl enable dispatch &>> /tmp/log.file
systemctl start dispatch &>> /tmp/log.file