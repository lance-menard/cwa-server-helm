#!/usr/bin/env bash

helm uninstall cwa-server -n cwa-server
kubectl delete namespace cwa-server