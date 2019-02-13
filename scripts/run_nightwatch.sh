#!/bin/sh

# wait for the selenium grid browser nodes to register with the selenium grid hub
sleep 5

if [ -n "$DEBUG" ] ; then
    npm run nightwatch-debug
else
    npm run nightwatch
fi
