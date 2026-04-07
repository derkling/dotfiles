#!/bin/bash -e

RANGE=${1:-HEAD~5..}

echo
echo "Checking rebase tested tag for [${RANGE}]..."
echo

git log --format="%h" $RANGE  | \
while read SHA1; do
  TAG=$(git show -s --format="%B" $SHA1  | awk '/Rebase-Tested/{printf("%s ", $0)}')
  TITLE=$(git show -s  --format="%h %s" $SHA1)
  echo "$TITLE | $TAG"
done | \
column -ts '|'

