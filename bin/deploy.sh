#!/bin/bash

read -r -p "You are about to deploy a new version of the app, are you sure? [y/N] " response
# response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then
  set -xe

  cd webapp
  npm ci
  npm run build
  cd ..

  docker-compose -f docker-compose.production.yml build web
  docker-compose -f docker-compose.production.yml down
  docker-compose -f docker-compose.production.yml up --no-deps -d
fi