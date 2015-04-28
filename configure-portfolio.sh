#!/bin/bash
# version 1.0 2014.24.01
echo "-> Fix permissions"
sudo chmod 777 -R /var/www/portfolio

echo "-> Create src directories"
mkdir /var/www/portfolio/src/Portfolio

echo "-> Register Symlinks"
ln -s /media/sf_github/Portfolio/PortfolioCoreBundle /var/www/portfolio/src/Portfolio/CoreBundle

echo "-> Enable VirtualHost"
sudo cp vhost/portfolio /etc/apache2/sites-available/portfolio
sudo cp vhost/portfolio /etc/apache2/sites-available/portfolio.conf
sudo a2ensite portfolio
sudo service apache2 restart

echo "-> Install Symfony"
cd /var/www/portfolio
echo "--> Downloading Composer"
curl -sS https://getcomposer.org/installer | php
php composer.phar config --global discard-changes true

echo "--> Install & update with composer"
php composer.phar self-update
sudo php composer.phar update # bug

echo "--> Fix permissions"
sudo chmod 777 -R app/logs

echo "--> Clear cache"
sudo chmod 777 -R app/cache
sudo php app/console cache:clear --env=dev # bug
sudo chmod 777 -R app/cache

cd ..