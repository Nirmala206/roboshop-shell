code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

echo -e "\e[35mInstalling nginx\e[0m"
yum install nginx -y &>>${log_file}

echo -e "\e[35mRemoving old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}

echo -e "\e[35mDowloading the frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

echo -e "\e[35mExtracting the downloaded frontend content\e[0m"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}

echo -e "\e[35mCopying the Nginx config for Roboshop\e[0m"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "\e[35mEnabling nginx\e[0m"
systemctl enable nginx &>>${log_file}
echo -e "\e[35mStarting nginx\e[0m"
systemctl start nginx &>>${log_file}