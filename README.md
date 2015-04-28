# DeployPortfolio

## Instructions

### 1. Preparations
While this script takes care of most of the installation procedure, you still need to type some commands manually to get it started.

Install git and prepare the installation directory:

	sudo apt-get install -y git
	sudo mkdir /var/www
	sudo chmod 777 -R /var/www
	cd /var/www

Now pull the most recent version of the installation script:

	git clone https://github.com/jplarar/DeployPortfolio .

And set it as executable

	chmod +x install.sh

### 2. Execute the script
To run the script, enter:

	./install.sh

The installation should only ask for your root password once to download packages (via `apt-get`) and perform some slight changes to your system configuration.

## Installation Order
1. LAMP stack
2. Symfony