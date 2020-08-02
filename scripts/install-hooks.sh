#!/usr/bin/env bash

set -e

ensure_running_from_root() {
  local _git_dir="${1}"

  if [[ ! -d "${_git_dir}" ]]; then
    echo "$0: must be run from nightwatch-docker-grid root" 1>&2
    exit 1
  fi
}

GIT_DIR="$(git rev-parse --git-dir)"
ensure_running_from_root "${GIT_DIR}"

path_to_pwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing hooks ..."

ln -s "${path_to_pwd}/pre-commit.sh" "${GIT_DIR}/hooks/pre-commit"

echo "Done!"
