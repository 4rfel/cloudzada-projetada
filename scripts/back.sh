#!/bin/bash
sudo apt update

sudo apt install git python3 python3-pip -y

pip3 isntall uvicorn fastapi

cd /home/ubuntu

git clone https://github.com/4rfel/cloudzada-projetada.git

crontab <<EOF
@reboot uvicorn tasklist.main:app --reload
EOF

# uvicorn tasklist.main:app --reload