#!/usr/bin/env bash

if [ -n "$DEBUG" ] ; then
    npm run nightwatch-debug
else
    npm run nightwatch
fi
