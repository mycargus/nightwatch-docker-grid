#!/usr/bin/env bash

ensure_running_from_root() {
  if [[ ! -d .git ]]; then
    echo "$0: must be run from koala-tea root" 1>&2
    exit 1
  fi
}

# export variables defined in ".env" but only if they're not already set
dotenv() {
  if [[ -f .env ]]; then
    IFS=$'\n' read -r -d '' -a items < .env

    for item in "${items[@]}"; do
      if [[ $item =~ ^\# ]]; then
        continue
      fi

      # shellcheck disable=SC2155
      local var="$(echo "$item" | cut -d'=' -f1)"

      if [[ -z ${!var} ]]; then
        export "${item?}"
      fi
    done
  fi
}

if [[ -t 0 ]]; then
  export di="--interactive"
fi
