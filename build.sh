#!/bin/bash

# Execute this script on a fresh Debain 12 installation as root
# ✅ - Update and upgrade the system
# ✅ - Install git, curl, net-tools, wget,zip, unzip, nano, tree, htop
# ✅ - create a new user and add it to the sudo group
# ✅ - Install apache2
# ✅ - Install PHP, Composer and Symfony Cli
# ✅ - Install NodeJs
# ☑️ - Install Java
# ☑️ - Install Python ?
# ✅ - Install Docker and docker-compose

function welcome_banner()
 {
    echo "############################################"
    echo "##                                        ##"
    echo "##  Initialize student workstation        ##"
    echo "##                                        ##"
    echo "############################################"
}

function step_banner()
{
  echo "+------------------------------------------+"
  printf "  %-40s |\n" "`date`"
  echo "                                            "
  printf " `tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

function update_system()
{
  step_banner "Update and upgrade the system"
  apt update -y
  apt upgrade -y
}

function installDebianPackages()
{
  step_banner "Install git, curl, net-tools, wget,zip, unzip, nano, tree, htop"
  apt install -y git curl net-tools wget zip unzip nano tree htop
}

function create_user()
{
  step_banner "Create a new user and add it to the sudo group"
  useradd -m -s /bin/bash -G sudo -p $2 $1
  echo "$1:$2" | chpasswd
}

function install_apache2()
{
  step_banner "Install apache2"
  apt install apache2 apache2-utils -y
  a2enmod rewrite
  a2enmod deflate
  a2enmod headers
  a2enmod ssl
  service apache2 restart
}

function install_php_composer_symfony()
{
  step_banner "Install PHP, Composer and Symfony Cli"
  apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
  apt install -y php \
      libapache2-mod-php \
      php-cli \
      php-fpm \
      php-json \
      php-pdo \
      php-mysql \
      php-zip \
      php-gd \
      php-mbstring \
      php-curl \
      php-xml \
      php-pear \
      php-bcmath \
      php-readline

  service apache2 restart

  curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
        mv composer.phar /usr/local/bin/composer

  curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
  apt install symfony-cli -y
}

function install_nodejs()
{
  step_banner "Install NodeJs"
  curl -sL https://deb.nodesource.com/setup_20.x | bash -
  apt install -y nodejs
}

function install_docker()
{
  step_banner "Install Docker and docker-compose"
  apt-get install ca-certificates curl -y
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update
  apt install docker.io docker-compose-plugin -y
}

welcome_banner
update_system
installDebianPackages
create_user $1 $2
install_apache2
install_php_composer_symfony
install_nodejs
install_docker













