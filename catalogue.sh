source common.sh

print_head "Configure NodeJs Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "Install NodeJs"
yum install nodejs -y &>>${log_file}
useradd roboshop &>>${log_file}
mkdir /app &>>${log_file}

rm -rf /app/* &>>${log_file}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app
unzip /tmp/catalogue.zip &>>${log_file}

npm install &>>${log_file}
cp configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

systemctl daemon-reload &>>${log_file}
systemctl enable catalogue &>>${log_file}
systemctl start catalogue &>>${log_file}

cp configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
yum install mongodb-org-shell -y &>>${log_file}
mongo --host mongodb.devops2023.tech </app/schema/catalogue.js &>>${log_file}
