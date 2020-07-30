#!/usr/bin/env bash

set -e

(echo "${DOCKER_PASSWORD}" | docker login --username="${DOCKER_USERNAME}" --password-stdin) || \
  (echo "Docker login failed!" && exit 1)

# TODO: get from package-lock.json
nightwatch_version=1.3.7

docker build --pull . --tag "${DOCKER_USERNAME}"/nightwatch:master

docker tag "${DOCKER_USERNAME}"/nightwatch:master "${DOCKER_USERNAME}"/nightwatch:"${nightwatch_version}"

docker push "${DOCKER_USERNAME}"/nightwatch:master
docker push "${DOCKER_USERNAME}"/nightwatch:"${nightwatch_version}"
