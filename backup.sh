pg_dumpall -U $POSTGRES_USER > dump.sql
aws s3 cp dump.sql s3://$AWS_BUCKET_NAME/dump.sql