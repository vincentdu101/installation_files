sudo apt-get install mysql-server
sudo /etc/init.d/mysql stop
sudo mysqld_safe --skip-grant-tables &
sudo apt-get install mysql-workbench


echo "Look inside the mysql.sh and follow the directions that are commented to reset password of root"
# mysql -u root
# use mysql;
# update user set password=PASSWORD("mynewpassword") where User='root';
# flush privileges;
# exit
# sudo /etc/init.d/mysql stop
# sudo /etc/init.d/mysql start
# mysql -u root -p