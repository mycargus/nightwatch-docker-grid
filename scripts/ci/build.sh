#!/usr/bin/env bash

set -ev

project_root="$(dirname "$(git rev-parse --git-dir)")"

npm ci
npm run lint
bash "$project_root"/lib/continuous_integration.bash lint_dockerfiles
bash "$project_root"/lib/continuous_integration.bash lint_shell

docker-compose pull
docker-compose build --pull
docker-compose up -d node-chrome node-firefox hub web

# wait for the selenium grid browser nodes to register with the selenium grid hub
sleep 5

docker-compose run --rm nightwatch && echo $?

exit_code=$?
echo "Nightwatch container exited with: ${exit_code}"

if [[ "${exit_code}" == "0" ]]; then
  echo ":: It's working!"
else
  echo ":: Test Failed :("
  exit_code=1
fi

exit ${exit_code}
