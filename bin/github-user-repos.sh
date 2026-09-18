#!/bin/sh
# Downloader.

set -euo pipefail

user_repos=$(
  gh api --paginate "/user/repos?type=owner" | jq -r ".[].name"
)
for user_repo in $user_repos
do
  rm -rf $user_repo
  gh repo clone $user_repo
done
