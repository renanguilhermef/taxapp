#!/bin/bash
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y
sudo dnf install mysql-community-server -y
sudo systemctl start mysqld

pass=$(grep "A temporary password" /var/log/mysqld.log | awk '{print $NF}')
new_pass="Database_538691"
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$new_pass';" | mysql -u root --password=$pass --connect-expired-password

echo "CREATE USER admin@'%' IDENTIFIED WITH mysql_native_password BY '$new_pass';" | mysql -u root --password=$new_pass
echo "GRANT ALL PRIVILEGES ON *.* TO admin@'%' WITH GRANT OPTION;FLUSH PRIVILEGES;" | mysql -u root --password=$new_pass