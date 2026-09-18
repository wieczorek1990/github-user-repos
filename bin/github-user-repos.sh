#!/bin/sh
# Downloader.

set -euo pipefail

user_repos=$(
  gh api --paginate "/user/repos?type=owner" | jq -r ".[].name"
)
for user_repo in $user_repos
do
  if [[ -d $user_repo ]]
  then
    cd $user_repo

    git pull

    cd - > /dev/null
  else
    gh repo clone $user_repo
  fi
done
