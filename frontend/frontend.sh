echo -e "\e[33m installing nginx \e[0m"
yum install nginx -y &>> /tmp/log.file
echo -e "\e[33m removing user share file \e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/log.file
echo -e "\e[33m downloading the required files \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/log.file
echo -e "\e[33m creating app dir and unzipping \e[0m"
cd /usr/share/nginx/html &>>/tmp/log.file
unzip /tmp/frontend.zip &>>/tmp/log.file

#we will give config files here
echo -e "\e[33m start nginx \e[0m"
systemctl enable nginx &>> /tmp/log.file
systemctl restart nginx &>> /tmp/log.file