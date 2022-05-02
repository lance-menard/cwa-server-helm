#!/usr/bin/env bash

source .env

for SERVICE in callback submission distribution download upload
do
  REPOSITORY="${REPOSITORY_ROOT}${SERVICE}"

  echo "Tagging ${SERVICE}..."
  docker tag cwa-server_${SERVICE}:latest ${REPOSITORY}:latest
  docker tag cwa-server_${SERVICE}:latest ${REPOSITORY}:${APP_VERSION}

  echo "Pushing ${SERVICE}..."
  docker push ${REPOSITORY} --all-tags
done