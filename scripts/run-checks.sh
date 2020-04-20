#!/bin/bash

. $PWD/scripts/message-handler.sh

echo_info 'Running lint...'
npm run lint || exit 1
echo_info 'Lint finished successfully!'

echo_info 'Running tests...'
npm run test || exit 1
echo_info 'Tests finished successfully!'