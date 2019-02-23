#!/usr/bin/env bash

set -e

path_to_pwd="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=lib/binutil.bash
source "$path_to_pwd/../lib/binutil.bash" &&
ensure_running_from_root

GIT_DIR="$(git rev-parse --git-dir)"

echo "Installing hooks ..."

ln -s "$path_to_pwd/pre-commit.sh" "$GIT_DIR/hooks/pre-commit"

echo "Done!"
