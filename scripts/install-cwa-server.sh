#!/usr/bin/env bash

source .env

kubectl create namespace cwa-server

function generateKey() {
  length=$1
  echo "$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c $length)"
}

# ./dist/cwa-server-${APP_VERSION}.tgz \
helm install cwa-server ./helm \
    --version ${APP_VERSION} \
    --namespace cwa-server \
    -f ./helm/values.yaml \
    --set-file pg.rolesScript=./helm/postgresql-setup/setup-roles.sql \
    --set-file pg.usersScript=./helm/postgresql-setup/create-users.sql \
    --set postgresql.auth.postgresPassword="$(generateKey 24)" \
    --set pg.flyway.password="$(generateKey 24)" \
    --set pg.submission.password="$(generateKey 24)" \
    --set pg.distribution.password="$(generateKey 24)" \
    --set pg.callback.password="$(generateKey 24)" \
    --set pg.download.password="$(generateKey 24)" \
    --set pg.upload.password="$(generateKey 24)" \
    --set pg.chgs_upload.password="$(generateKey 24)" \
    --set objectstore.accessKey="$(generateKey 20)" \
    --set objectstore.secretKey="$(generateKey 20)"