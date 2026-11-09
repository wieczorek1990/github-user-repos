#!/bin/sh
# Downloader.

set -euo pipefail

echo "Will use gh tool from GitHub to download owner repositories."
user_repos=$(
  gh api --paginate "/user/repos?type=owner" | jq -r ".[].name"
)
for user_repo in $user_repos
do
  echo "Processing: $user_repo"
  if [[ -d $user_repo ]]
  then
    echo 'It exists already.'

    cd $user_repo

    git pull
    git lfs pull

    cd - > /dev/null
  else
    echo "Will clone."

    gh repo clone $user_repo
  fi
done
