source common.sh

mysql_root_password=$1

if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mMissing MySQL Root Password argument\e[0m"
  exit 1
fi

print_head "Setup Erlang repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log_file}
status_check $?

#print_head "Copy SystemD Service File"
#yum install erlang -y &>>${log_file}
#status_check $?

print_head "Setup RabbitMQ Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head "Install Erlang & RabbitMQ"
yum install rabbitmq-server erlang -y &>>${log_file}
status_check $?

print_head "Enable RabbitMQ Service"
systemctl enable rabbitmq-server &>>${log_file}
status_check $?

print_head "Start RabbitMQ Service"
systemctl start rabbitmq-server &>>${log_file}
status_check $?

print_head "Add Application user"
rabbitmqctl list_users | grep roboshop  &>>${log_file}
if [ $? -ne 0 ]; then
rabbitmqctl add_user roboshop ${mysql_root_password} &>>${log_file}
fi
status_check $?

#print_head "Copy SystemD Service File"
#rabbitmqctl set_user_tags roboshop administrator &>>${log_file}
#status_check $?

print_head "Configure Permissions for App User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status_check $?