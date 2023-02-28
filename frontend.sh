echo -e "\e[31mInstalling nginx\e[0m"
yum install nginx -y
echo -e "\e[31mRemoving old content\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[31mDowloading the frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
echo -e "\e[31mExtracting the downloaded frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[31mCopying the Nginx config for Roboshop\e[0m"
cp configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[31mEnabling nginx\e[0m"
systemctl enable nginx
echo -e "\e[31mStarting nginx\e[0m"
systemctl start nginx