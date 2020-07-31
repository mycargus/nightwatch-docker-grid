#!/usr/bin/env bash

set -e

(echo "${DOCKER_PASSWORD}" | docker login --username="${DOCKER_USERNAME}" --password-stdin) || \
  (echo "Docker login failed!" && exit 1)

# TODO: get from package-lock.json
nightwatch_version=1.3.7

docker build --pull . --tag "${DOCKER_USERNAME}"/nightwatch:master

(docker run --rm "${DOCKER_USERNAME}"/nightwatch:master nightwatch --version | grep "${nightwatch_version}") || \
  (echo "The Nightwatch version and docker image tag version don't match. Aborting ..." && exit 1)

docker tag "${DOCKER_USERNAME}"/nightwatch:master "${DOCKER_USERNAME}"/nightwatch:"${nightwatch_version}"

docker push "${DOCKER_USERNAME}"/nightwatch:master
docker push "${DOCKER_USERNAME}"/nightwatch:"${nightwatch_version}"
