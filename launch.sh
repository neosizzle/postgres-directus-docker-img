sudo apt-get install docker git
sudo git clone https://github.com/neosizzle/postgres-directus-docker-img.git
cd postgres-directus-docker-img
echo "SOMEENV=VALUE" >> .env.prod
mv .env.prod .env
docker-compose up -d --build
until docker exec postgres-autobackup bash init_setup.sh
do
    echo "Attempting to do initial setup..."
    sleep 1
done