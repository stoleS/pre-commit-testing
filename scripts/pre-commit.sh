#!/bin/bash

. $PWD/scripts/error-exit.sh

STASH_NAME="pre-commit-$(date +%s)"
git stash save -q --keep-index $STASH_NAME

bash $PWD/scripts/run-checks.sh
CHECKS_RESULT=$?

STASHES=$(git stash list)
if [[ $STASHES =~ "$STASH_NAME" ]]; then
  git stash pop -q
fi

[ $CHECKS_RESULT -ne 0 ] && 2>/dev/null && error_exit "Checks failed to pass! Commit aborted!"
echo '-> Checks passed successfully! Commit alowed!'
exit 0

