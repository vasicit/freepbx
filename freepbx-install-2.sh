#!/bin/bash
yum -y update
yum -y groupinstall core base "Development Tools"
yum install gcc gcc-c++ lynx bison mysql-devel mysql-server php php-mysql php-pear php-mbstring php-xml tftp-server httpd make ncurses-devel libtermcap-devel sendmail sendmail-cf caching-nameserver sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git subversion kernel-devel php-process crontabs cronie cronie-anacron wget vim php-xml uuid-devel libtool sqlite-devel unixODBC mysql-connector-odbc libuuid-devel binutils-devel php-ldap
chkconfig --level 0123456 iptables off
service iptables stop
chkconfig --level 345 mysqld on
service mysqld start
chkconfig --level 345 httpd on
service httpd start
pear channel-update pear.php.net
pear install db-1.7.14
wait ${!}
reboot
