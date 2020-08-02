#!/usr/bin/env bash

if [ "x$DEBUG" == "x" ] ; then
  npm run nightwatch
else
  npm run nightwatch-debug
fi
