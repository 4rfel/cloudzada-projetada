#!/bin/bash
sudo apt update

npm install express --save

npm install body-parser --save

git clone https://github.com/4rfel/cloudzada-projetada.git

cd cloudzada-projetada/tasklist

crontab <<EOF
@reboot uvicorn cloudzada-projetada.tasklist.main:app --reload
EOF

# uvicorn tasklist.main:app --reload