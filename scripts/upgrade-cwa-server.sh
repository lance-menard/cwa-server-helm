#!/usr/bin/env bash

source .env

# ./dist/cwa-server-${APP_VERSION}.tgz \
helm upgrade cwa-server ./helm \
    --version ${APP_VERSION} \
    --namespace cwa-server \
    --reuse-values