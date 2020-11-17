#!/bin/sh
mkdir aaaaaaaaa

sudo apt update

git clone https://github.com/4rfel/cloudzada-projetada.git

cd cloudzada-projetada/app

sudo apt install npm -y

npm install express
npm install sequelize
npm install mysql2
npm install body-parser
npm install cors
npm install uuid


crontab <<EOF
@reboot ~/cloudzada-projetada/app/server.js
EOF

