#!/bin/sh

. $(dirname "$0")/error-exit.sh

SCRIPTS_LOC="scripts"
PRE_COMMIT_LOC=".git/hooks/pre-commit"
PRE_COMMIT_SCRIPT_LOC="$SCRIPTS_LOC/pre-commit.sh"
RUN_TESTS_SCRIPT_LOC="$SCRIPTS_LOC/run-tests.sh"

echo '-> installing pre-commit script...'
ln -s $PWD/$PRE_COMMIT_SCRIPT_LOC $PWD/$PRE_COMMIT_LOC 2>/dev/null || error_exit "Failed to create syslink at $PRE_COMMIT_LOC!"
echo 'done'

echo '-> making it executable...'
chmod +x $PWD/$PRE_COMMIT_LOC 2>/dev/null || error_exit "Failed to make pre-commit script executable!"
echo 'done'

echo '-> everyting set!'