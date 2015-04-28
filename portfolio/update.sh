#!/usr/bin/env bash
echo - Update packages with composer -
php composer.phar self-update
sudo php composer.phar update # bug

echo - Fix permissions -
sudo chmod 777 -R app/logs

echo - Clear cache -
sudo chmod 777 -R app/cache
sudo php app/console cache:clear --env=prod # bug
sudo chmod 777 -R app/cache

echo - Update database -
php app/console doctrine:schema:update --force

echo - Assets install -
sudo php app/console assets:install