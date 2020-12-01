#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt update

cd /home/ubuntu
mkdir database
cd database
mkdir scripts
cd scripts
cat > ./setup_db.sql <<EOF
DROP DATABASE IF EXISTS bd_test;
CREATE DATABASE bd_test;

DROP DATABASE IF EXISTS db_real;
CREATE DATABASE db_real;

DROP USER IF EXISTS db_adm@"%";
CREATE USER db_adm@"%" IDENTIFIED BY "senha_segura_para_adm";
GRANT ALL ON bd_test.* TO db_adm@"%";
GRANT ALL ON db_real.* TO db_adm@"%";

DROP USER IF EXISTS db_user@"%";
CREATE USER db_user@"%" IDENTIFIED BY "a-melhor-senha-q-vc-ja-viu";
GRANT SELECT, INSERT, UPDATE, DELETE ON bd_test.* TO db_user@"%";
GRANT SELECT, INSERT, UPDATE, DELETE ON db_real.* TO db_user@"%";

COMMIT;

USE db_real;
DROP TABLE IF EXISTS todos;

CREATE TABLE todos (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(120),
    updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
EOF
cd ..

crontab <<EOF
@reboot sudo docker run -d -p 80:3306 --name=db_user \
    -e MYSQL_ROOT_PASSWORD="a-melhor-senha-q-vc-ja-viu" \
    -v /home/ubuntu/database/scripts:/docker-entrypoint-initdb.d \
    mysql:latest
EOF

sudo docker run -d -p 80:3306 --name=db_user \
    -e MYSQL_ROOT_PASSWORD="a-melhor-senha-q-vc-ja-viu" \
    -v /home/ubuntu/database/scripts:/docker-entrypoint-initdb.d \
    mysql:latest