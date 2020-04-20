#!/bin/bash

. $PWD/scripts/message-handler.sh

SCRIPTS_LOC="scripts"
PRE_COMMIT_LOC=".git/hooks/pre-commit"
PRE_COMMIT_SCRIPT_LOC="$SCRIPTS_LOC/pre-commit.sh"
RUN_TESTS_SCRIPT_LOC="$SCRIPTS_LOC/run-tests.sh"

echo_info 'Checking for older versions...'
if [ -f "$PRE_COMMIT_LOC" ]; then
  echo_info 'Older version found!'
  echo_info 'Removing older version...'
  rm $PRE_COMMIT_LOC 2>/dev/null || error_exit "Failed to remove older pre-commit version!"
  echo_info 'Older version successfully removed!'
else 
    echo_info "Older version not found!"
fi

echo_info 'Installing pre-commit script...'
ln -s $PWD/$PRE_COMMIT_SCRIPT_LOC $PWD/$PRE_COMMIT_LOC 2>/dev/null || error_exit "Failed to create syslink at $PRE_COMMIT_LOC!"
echo_info 'Success!'

echo_info 'Making it executable...'
chmod +x $PWD/$PRE_COMMIT_LOC || error_exit "Failed to make pre-commit script executable!"
echo_info 'Success!'

echo_info 'Everyting set!'