#!/bin/bash

# Perform versions checking of the installed tools, must be run as freshly created user

function welcome_banner()
 {
    echo "############################################"
    echo "##                                        ##"
    echo "##  Checking Installation                 ##"
    echo "##                                        ##"
    echo "############################################"
}

function CheckToolsInstalledVersions()
{
  echo "###############  Git #######################"
  echo "$(git --version)"
  echo "############### Apache2 ####################"
  echo "$(apache2 -v)"
  echo "############### PHP ########################"
  echo "$(php -v)"
  echo "############### Composer ###################"
  echo "$(composer --version -y)"
  echo "############### Symfony ####################"
  echo "$(symfony -V)"
  echo "############### NodeJs #####################"
  echo "$(nodejs -v)"
  echo "############### NPM ########################"
  echo "$(npm -v)"
  echo "############### Docker #####################"
  echo "$(docker -v)"
  echo "############### Docker compose #############"
  echo "$(docker compose version)"
  echo "##########################################"
  echo " You can make your own git configuration !"
}

welcome_banner
CheckToolsInstalledVersions