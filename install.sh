#!/bin/bash
# version 3.0 2014.12.0

echo Starting installation procedure..

echo -e "\e[1m--- Install Java ---\e[0m"
sudo apt-get update > /dev/null
sudo apt-get install -y openjdk-7-jre

echo -e "\e[1m--- Installing LAMP Stack ---\e[0m"
echo - Update Repositories -
sudo add-apt-repository -y ppa:ondrej/php5-oldstable > /dev/null
sudo apt-get update > /dev/null

echo -e "\e[1m--- Install Apache2 ---\e[0m"
sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo service apache2 restart

echo -e "\e[1m--- Install PHP5.5 ---\e[0m"
sudo apt-get install -y php5
sudo apt-get install -y libapache2-mod-php5
sudo service apache2 restart

echo - Install PHP5 MySQL Drivers -
sudo apt-get install -y php5-mysql

echo - Install cURL -
sudo apt-get install -y php5-curl
sudo service apache2 restart

echo -e "\e[1m--- Install MySQL ---\e[0m"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password devroot'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password devroot'
sudo apt-get install -y mysql-server
sudo apt-get install -y php5-mysql

echo -e "\e[1m--- User permisssions ---\e[0m"
sudo adduser ubuntu vboxsf
sudo adduser ubuntu www-data
sudo usermod -a -G vboxsf www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rw /var/www

echo -e "\e[1m--- Configure Apache & Virtual Hosts ---\e[0m"
echo - Prepare log files -
sudo mkdir /etc/apache2/logs
sudo chmod 777 -R /etc/apache2/logs
sudo cp vhost/portfolio.conf /etc/apache2/sites-available/portfolio.conf
sudo a2ensite portfolio
sudo service apache2 restart

echo -e "\e[1m--- File permissions ---\e[0m"
    chmod +x update.sh
    chmod +x install.sh

    sudo chmod 777 -R /var/www

    echo -e "\e[1m--- Install Applications ---\e[0m"
    for i in "portfolio"
    do
        cd ${i}
        curl -sS https://getcomposer.org/installer | php
        cd ..
    done


echo "[All Done]"