#!/usr/bin/env bash

ensure_running_from_root() {
  if [[ ! -d .git ]]; then
    echo "$0: must be run from nightwatch-docker-grid root" 1>&2
    exit 1
  fi
}

if [[ -t 0 ]]; then
  export di="--interactive"
fi
