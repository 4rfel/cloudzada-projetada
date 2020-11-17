#!/bin/bash
sudo apt update

sudo apt install npm -y

npm install express sequelize mysql2 body-parser cors uuid

git clone https://github.com/4rfel/cloudzada-projetada.git

cd cloudzada-projetada/tasklist

crontab <<EOF
@reboot
EOF

