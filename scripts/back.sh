#!/bin/bash

cd /home/ubuntu

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt install git -y

git clone https://github.com/4rfel/cloudzada-projetada.git

cd cloudzada-projetada/api


crontab <<EOF
@reboot sudo docker run -it --rm -d -p 80:8001 -e DB_DSN="db_user:a-melhor-senha-q-vc-ja-viu@tcp(172.31.48.5:80)/db_real?charset=utf8mb4&parseTime=True&loc=Local" --name jose db_api

EOF

sudo docker build -t db_api .

sudo docker run -it --rm -d -p 80:8001 -e DB_DSN="db_user:a-melhor-senha-q-vc-ja-viu@tcp(172.31.48.5:80)/db_real?charset=utf8mb4&parseTime=True&loc=Local" --name jose db_api
