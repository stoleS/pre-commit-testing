#!/bin/bash

echo '-> running tests...'
npm run test || >&2
echo 'done'

echo '-> running lint...'
npm run lint
echo 'done'
