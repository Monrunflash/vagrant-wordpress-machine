#!/bin/bash

apt-get update
apt-get install -y apache2 mariadb-server php libapache2-mod-php php-mysql
service apache2 restart

wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz -C /var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i 's/database_name_here/wordpress/g' /var/www/html/wordpress/wp-config.php
sed -i 's/username_here/wordpress/g' /var/www/html/wordpress/wp-config.php
sed -i 's/password_here/CaM1n0K0y0T3/g' /var/www/html/wordpress/wp-config.php
sed -i 's/localhost/localhost/g' /var/www/html/wordpress/wp-config.php

cat <<EOF >> /var/www/html/wordpress/wp-config.php

define( 'FS_METHOD', 'direct' );
EOF

cat <<EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/wordpress/
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2ensite wordpress.conf
a2enmod rewrite
service apache2 restart

mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'CaM1n0K0y0T3'"
mysql -u root -e "FLUSH PRIVILEGES"
