#!/bin/bash

set -euo pipefail

codeDir='/home/zaiquiri/Nextcloud/Code'

if [[ ! -d "$codeDir" ]]; then
  echo "code directory $codeDir does not exist"
  exit 1
fi

cd $codeDir
# find Project
projectDir=$(fd --type d --max-depth 1 . | fzf --prompt='Projects> ')

if [ -n "$projectDir" ]; then
  cd "$codeDir/$projectDir"
  nvim .
fi
