#!/usr/bin/env bash

db_instance_name=$1
db_password=$2
PGPASSWORD=$db_password
$sql_public_ip=$3


gcloud gcloud sql users set-password postgres --instance=$db_instance_name --password=$db_password

sed "s/PG_PASSWORD/'${db_password}'/g" database.sql | psql -h $sql_public_ip -U postgres postgres
