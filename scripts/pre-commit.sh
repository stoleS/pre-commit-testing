#!/bin/bash

. $PWD/scripts/message-handler.sh

STASH_NAME="pre-commit-$(date +%s)"
git stash save -q --keep-index $STASH_NAME

. $PWD/scripts/check-changes.sh
CHECKS_RESULT=$?

STASHES=$(git stash list)
if [[ $STASHES =~ "$STASH_NAME" ]]; then
  git stash pop -q
fi

[ $CHECKS_RESULT -ne 0 ] && 2>/dev/null && error_exit "Checks failed to pass! Commit aborted!"
echo_info 'Checks passed successfully! Commit alowed!'
exit 0

