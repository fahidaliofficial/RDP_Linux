#! /bin/bash
clear
sudo rm Loop.sh
sudo service chrome-remote-desktop start

sudo wget https://raw.githubusercontent.com/amitstudydude/RDP_Linux/main/Loop.sh

sudo systemctl start chrome-remote-desktop@$USER

sudo systemctl status chrome-remote-desktop@$USER

bash Loop.sh
clear
