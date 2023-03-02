source common.sh


print_head "Setup MongoDB repository"
cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install MongoDB"
yum install mongodb-org -y

print_head "Enable MongoDB"
systemctl enable mongod

print_head "Start MongoDB service"
systemctl start mongod

#udate /etc/mongod.conf file from 127.0.0.1 to 0.0.0.0

