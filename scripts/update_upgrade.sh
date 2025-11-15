#!/bin/bash

echo "- - - UPDATE - - -"
sudo apt update -y

echo "- - - UPGRADE - - -"
sudo apt upgrade -y

echo "- - - AUTOREMOVE && AUTOCLEAN - - -"
sudo apt autoremove && sudo apt autoclean
