#if there is no psotgres default files
if [ ! -d "$PGDATA/postgresql.conf" ]
then
	#install psotgres  default files and create database
	useradd $POSTGRES_USER
	echo $POSTGRES_PASSWORD > pwfile
	echo "create user $POSTGRES_USER password '$POSTGRES_PASSWORD'; create database $POSTGRES_USER;" > init.sql
	sudo -E -u postgres /usr/lib/postgresql/14/bin/initdb -U postgres
	rm pwfile
	echo "host  all  all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf
	sudo -E -u postgres /usr/lib/postgresql/14/bin/postgres >logfile 2>&1 &
	sleep 5
	sudo -E -u postgres createdb dbname postgres
	sudo -E -u postgres  /usr/lib/postgresql/14/bin/psql --file=init.sql

else
	echo "[INFO] postgres is already initialized..."
fi