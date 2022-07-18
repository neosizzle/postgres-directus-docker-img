#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

cd /home/ubuntu
apt-get update -y && sudo apt-get upgrade -y
apt-get install docker.io git curl -yqq
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
mv /usr/local/bin/docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
git clone https://github.com/neosizzle/postgres-directus-docker-img.git
cd postgres-directus-docker-img
echo "SOMEENV=VALUE" >> .env.prod
mv .env.prod .env
docker-compose up -d --build
until docker exec postgres-autobackup bash init_setup.sh
do
    echo "Attempting to do initial setup..."
    sleep 1
done