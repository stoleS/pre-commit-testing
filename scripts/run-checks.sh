#!/bin/bash

echo '-> running tests...'
npm run test
echo 'done'

echo '-> running lint...'
npm run lint
echo 'done'
