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
clear

# Config
readonly codeDir="$HOME/Code"

# Sanity check
if [[ ! -d "$codeDir" ]]; then
  echo "Code directory $codeDir does not exist." >&2
  exit 1
fi

cd "$codeDir"

# Build menu options
mapfile -t projects < <(fd --type d --max-depth 1 . | sort)
projects=("📁 Add New Project" "${projects[@]}")

# Project selection
selectedProject=$(
  printf '%s\n' "${projects[@]}" | gum filter \
    --placeholder="Search or add..." \
    --indicator="🚀" \
    --height=20 \
    --header="Select a project"
)

if [[ "$selectedProject" == "📁 Add New Project" ]]; then
  # Prompt for new project name
  newProject=$(gum input --placeholder="Enter new project name" --prompt="📂 New project name: ")

  # Abort if empty
  if [[ -z "$newProject" ]]; then
    echo "❌ No name entered. Aborting."
    exit 1
  fi

  # Confirm creation
  if gum confirm "Create project folder: $codeDir/$newProject?"; then
    mkdir -p "$codeDir/$newProject"
    cd "$codeDir/$newProject"
    nvim .
  else
    echo "🚫 Aborted by user."
    exit 1
  fi
elif [[ -n "$selectedProject" ]]; then
  # Open selected existing project
  cd "$codeDir/$selectedProject"
  nvim .
else
  echo "❌ No directory entered. Aborting."
fi
