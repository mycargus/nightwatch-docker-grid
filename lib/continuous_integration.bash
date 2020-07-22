#!/usr/bin/env bash

lint_dockerfiles() {
  bin/lint_dockerfiles docker/*/Dockerfile
}

lint_shell() {
  bin/lint_shell -x \
    bin/* \
    lib/*.bash \
    scripts/*.sh
}

"$@"
