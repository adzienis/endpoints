#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE events_app_development;
    CREATE DATABASE events_app_test;
    GRANT ALL PRIVILEGES ON DATABASE events_app_development, events_app_test TO $POSTGRES_USER;
EOSQL
