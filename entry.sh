sudo -E -u postgres /usr/lib/postgresql/14/bin/postgres >logfile 2>&1 &

#write out current crontab
# crontab -l > mycron


echo "POSTGRES_USER=$POSTGRES_USER" >> /etc/environment
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> /etc/environment
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> /etc/environment
echo "AWS_BUCKET_NAME=$AWS_BUCKET_NAME" >> /etc/environment
echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION" >> /etc/environment
#echo new cron into cron file
echo "* * * * * bash /backup.sh > /proc/1/fd/1 2>/proc/1/fd/2" >> mycron 

#install new cron file
crontab mycron
# rm mycron

cron -f 