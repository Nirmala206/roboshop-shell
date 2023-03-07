source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mMissing MySQL Root Password argument\e[0m"
  exit 1
fi

print_head "Disabling MySql 8 version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "Copy MySQL repo file"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head "Installing MySql Server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "Enablw MySql service"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "Start MySql service"
systemctl start mysqld &>>${log_file}
status_check $?

print_head "Set Root Password"
mysql -uroot -p${mysql_root_password}
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}
status_check $?
