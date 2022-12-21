#!/bin/bash
service firewalld stop
chkconfig firewalld off
yum -y install httpd mod_ssl
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
systemctl restart httpd.service
sudo systemctl enable httpd
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install php56w php56w-pdo php56w-mysql php56w-mbstring php56w-pear php56w-process php56w-xml php56w-opcache php56w-ldap php56w-intl php56w-soap -y
sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php.ini
cd /var/www
cp /contrib/httpd/asterisk-cdr-viewer.conf /etc/httpd/conf.d/
