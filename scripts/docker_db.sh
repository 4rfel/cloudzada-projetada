#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt update

sudo apt install git python3 -y

cd /home/ubuntu
mkdir database
cd database
mkdir scripts
cd scripts
cat > ./setup_db.sql <<EOF
DROP DATABASE IF EXISTS tasklist;
CREATE DATABASE tasklist;

DROP USER IF EXISTS tasklist_admin@localhost;
CREATE USER tasklist_admin@localhost IDENTIFIED BY "senha_root";
GRANT ALL ON tasklist.* TO tasklist_admin@localhost;
GRANT ALL ON tasklist_test.* TO tasklist_admin@localhost;

DROP USER IF EXISTS tasklist_app@localhost;
CREATE USER tasklist_app@localhost IDENTIFIED BY "senha_app";
GRANT SELECT, INSERT, UPDATE, DELETE ON tasklist.* TO tasklist_app@localhost;
GRANT SELECT, INSERT, UPDATE, DELETE ON tasklist_test.* TO tasklist_app@localhost;

COMMIT;

USE tasklist;

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
    uuid BINARY(16) PRIMARY KEY,
    description NVARCHAR(1024)
);
EOF
cd ..

crontab <<EOF
@reboot sudo docker run -d -p 80:3306 --name=cloudzada-do-4-mysql \
    -e MYSQL_ROOT_PASSWORD="a-melhor-senha-q-vc-ja-viu" \
    -v ./scripts:/docker-entrypoint-initdb.d \
    mysql:latest
EOF

sudo docker run -d -p 80:3306 --name=cloudzada-do-4-mysql \
    -e MYSQL_ROOT_PASSWORD="a-melhor-senha-q-vc-ja-viu" \
    -v ./scripts:/docker-entrypoint-initdb.d \
    mysql:latest