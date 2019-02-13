#!/bin/sh

# wait for the selenium grid browser nodes to register with the selenium grid hub
if [ -n "$CI" ]; then
  sleep 12
else
  sleep 3
fi

if [ -n "$DEBUG" ] ; then
    npm run nightwatch-debug
else
    npm run nightwatch
fi
