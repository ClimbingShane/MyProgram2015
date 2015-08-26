#install rpm
ls mysql-libs-5.1.66-2.el6_3.x86_64.rpm|xargs rpm -ivh;
ls mysql-5.1.66-2.el6_3.x86_64.rpm|xargs rpm -ivh;
ls perl-DBD-MySQL-4.013-3.el6.x86_64.rpm|xargs rpm -ivh;
ls mysql-server-5.1.66-2.el6_3.x86_64.rpm|xargs rpm -ivh;
ls mysql-devel-5.1.66-2.el6_3.x86_64.rpm|xargs rpm -ivh; 

#cp my.cnf to /etc/
\cp my.cnf /etc;

#start mysql
service mysqld start;

#configure mysql
mysql <<END
use mysql;
update user set password=password('123456') where user='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
flush privileges;
END

#reload mysql
service mysqld restart;
service mysqld status;

#set auto_boot
chkconfig --level 35 mysqld on;

