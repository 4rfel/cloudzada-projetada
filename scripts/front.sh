#!/bin/bash

cd /home/ubuntu

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install git -y

git clone https://github.com/4rfel/cloudzada-projetada.git

cd cloudzada-projetada/front-original-100porcento-atualizado


crontab <<EOF
@reboot sudo docker run -d -p 80:5000 --name=run-siteza-da-massa siteza-da-massa
EOF

sudo docker build -t siteza-da-massa --build-arg API_URL="http://${IP_DO_BACK}" .
sudo docker run -d -p 80:5000 --name=run-siteza-da-massa siteza-da-massa