#!/bin/bash

echo '-> running lint...'
npm run lint || exit 1
echo 'done'

echo '-> running tests...'
npm run test || exit 1
echo 'done'