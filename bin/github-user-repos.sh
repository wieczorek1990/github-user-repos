#!/bin/sh
# Downloader.

set -euo pipefail

user_repos=$(
  gh api --paginate "/user/repos?type=owner" | jq -r ".[].name"
)

read -p "Owner: " owner
ssh-add

for user_repo in $user_repos
do
  gh repo clone $user_repo
done
