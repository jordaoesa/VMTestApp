#!/bin/bash

sudo su <<HERE

echo "---------------------------------";
echo "------ Instalação Asterisk ------";
echo "---------------------------------";

sudo apt-get update;

sudo apt-get install asterisk;

wget https://raw.githubusercontent.com/jordaoesa/VMTestApp/master/config_asterisk.sh

sh config_asterisk.sh

HERE

