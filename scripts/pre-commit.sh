#!/bin/sh

STASH_NAME="pre-commit-$(date +%s)"
echo $STASH_NAME
git stash save -q --keep-index $STASH_NAME

#sh $PWD/scripts/run-checks.sh
TEST_RESULT=$?

STASHES=$(git stash list)
echo $STASHES
if [[ $STASHES == "$STASH_NAME" ]]; then
  git stash pop -q
fi

[ $TEST_RESULT -ne 0 ] && exit 1
exit 0

