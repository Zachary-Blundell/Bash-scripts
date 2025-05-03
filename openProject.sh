#!/bin/bash
#    ____                      ____               _           __
#   / __ \____  ___  ____     / __ \_________    (_)__  _____/ /_
#  / / / / __ \/ _ \/ __ \   / /_/ / ___/ __ \  / / _ \/ ___/ __/
# / /_/ / /_/ /  __/ / / /  / ____/ /  / /_/ / / /  __/ /__/ /_
# \____/ .___/\___/_/ /_/  /_/   /_/   \____/_/ /\___/\___/\__/
#     /_/                                  /___/
# Author : Zachary Blundell
# Simple script for opening coding projects with Neovim

set -euo pipefail

codeDir='/home/zaiquiri/Nextcloud/Code'

if [[ ! -d "$codeDir" ]]; then
  echo "code directory $codeDir does not exist"
  exit 1
fi

cd $codeDir
# find Project
projectDir=$(
  fd --type d --max-depth 1 . | fzf --prompt='Projects> ' \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --color=border:#313244,label:#cdd6f4 \
    --border="rounded" --border-label="Code Projects" --border-label-pos="0" --preview-window="border-rounded" \
    --padding="2" --margin="10%" --marker="" \
    --pointer="🚀" --separator="─" --scrollbar="│" --layout="reverse" \
    --info="right"
)

if [ -n "$projectDir" ]; then
  cd "$codeDir/$projectDir"
  nvim .
fi
