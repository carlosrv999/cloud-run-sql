#!/usr/bin/env bash

db_instance_name=$1
db_password=$2
sql_public_ip=$3

gcloud sql users set-password postgres --instance=$db_instance_name --password=$db_password

sed "s/PG_PASSWORD/'${db_password}'/g" database.sql | PGPASSWORD=$db_password psql -h $sql_public_ip -U postgres postgres
