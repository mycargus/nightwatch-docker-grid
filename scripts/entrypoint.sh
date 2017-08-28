#!/bin/sh

# install
npm install --ignore-scripts --unsafe-perm --loglevel warn
# launch
if [ -n "$DEBUG" ] ; then
    npm run debug
else
    npm run nightwatch
fi