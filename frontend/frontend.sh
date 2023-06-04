source common.sh

echo -e "${color} installing nginx ${nocolor}"
yum install nginx -y &>> ${log_file}

echo -e "${color} removing user share file ${nocolor}"
rm -rf /usr/share/nginx/html/* &>> ${log_file}

echo -e "${color} downloading the required files ${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log_file}

echo -e "${color} creating app dir and unzipping ${nocolor}"
cd /usr/share/nginx/html &>> ${log_file}
unzip /tmp/frontend.zip &>>${log_file}

echo -e "${color} update front end config ${nocolor}"
cp/home/centos/Roboshop-shell/frontend.conf  /etc/nginx/default.d/roboshop.conf  &>> ${log_file}

echo -e "${color} start nginx ${nocolor}"
systemctl enable nginx &>> ${log_file}
systemctl restart nginx &>> ${log_file}