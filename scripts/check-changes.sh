#!/bin/bash

STAGED=$(git diff --name-only --cached)

package="/package.json"
git="/.git"

find_package() {
  parentDirectory=$(dirname $1)
  if [ -f $parentDirectory$package ]; then
    RESULT=$parentDirectory$package
  elif [ -d $parentDirectory$git ]; then
    RESULT=''
  else
    RESULT=$(find_package $parentDirectory)
  fi
  echo $RESULT
}

SERVICES=()
set -f; IFS=$'\n'
for staged in $STAGED; do
  item=$(find_package $staged)
  if [[ -z "$item" ]]; then
    echo skipped $staged
  elif grep -q precommit "$item"; then
    SERVICES+=($PWD/$(dirname $item))
  fi
done

for service in $SERVICES; do
  cd $service
  npm run precommit
done