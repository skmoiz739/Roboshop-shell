echo -e "\e[33m installing nginx \e[0m"
yum install nginx -y &>> /tmp/log.file
echo -e "\e[33m removing user share file \e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[33m downloading the required files \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[33m creating app dir and unzipping \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#we will give config files here
echo -e "\e[33m start nginx \e[0m"
systemctl enable nginx
systemctl restart nginx