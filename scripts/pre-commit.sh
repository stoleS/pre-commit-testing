#!/bin/bash

. $PWD/scripts/message-handler.sh

STAGED=$(git diff --name-only)

STASH_NAME="pre-commit-$(date +%s)"
git stash save -q --keep-index $STASH_NAME

package="/package.json"
git="/.git"

# Function for finding package.json in changed file parent
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

# Main function that collects all package.json services 
# that have changed files and precommit script
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

# Remove duplicates from previous function result
IFS=$' '
CHANGED=($(printf "%s\n" "${SERVICES[@]}" | sort -u | tr '\n' ' '))
unset IFS

# Loop through changed directories that have precommit script
# and run it
for changed in "${CHANGED[@]}"; do
  cd $changed
  current=$(basename "$PWD")
  echo_info "Running checks for /$current service..."
  npm run precommit
  CHECKS_RESULT=$?
  [ $CHECKS_RESULT -ne 0 ] && echo_error "Checks failed to pass for /$current service!"
  echo_info "Checks passed successfully for /$current service!"
done

STASHES=$(git stash list)
if [[ $STASHES =~ "$STASH_NAME" ]]; then
  git stash pop -q
fi

[ $CHECKS_RESULT -ne 0 ] && 2>/dev/null && error_exit "Commit aborted!"
echo_info "Checks passed successfully! Commit alowed!"
exit 0

