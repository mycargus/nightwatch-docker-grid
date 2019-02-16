#!/usr/bin/env bash

set -ev

export COMPOSE_FILE=docker-compose.yml

function cleanup()
{
  exit_code=$?

  echo ":: Cleaning up"

  docker-compose kill
  docker-compose rm -fv

  if [[ "${exit_code}" == "0" ]]; then
    echo ":: It's working!"
  else
    echo ":: Build Failed :("
  fi
}

trap cleanup INT TERM EXIT

docker-compose build --pull
docker-compose up -d node-chrome node-firefox hub web

# wait for the selenium grid browser nodes to register with the selenium grid hub
sleep 5

docker-compose up testrunner
