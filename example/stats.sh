#!/bin/bash
 
set -e
 
git rev-list --reverse HEAD | # get commits from latest to earliest
while read rev; do
  echo; # print newline
  echo REV $rev; # print REV some_hash
  git ls-tree -r $rev | # recursively get all of the trees changed files
  awk '{print $3}'| # get row 3 (shows entire changeset from commit)
  xargs git show | # pipe to xargs
  wc -l; # word count by line
done # YAY STATS
