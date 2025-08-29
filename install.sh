#!/usr/bin/env bash
set -euo pipefail

# Directory where your scripts live
SCRIPT_DIR="$HOME/Code/Bash-scripts/" # change this to your folder

# Fake script names for now
scripts=("skeymaker" "sconnect" "openProject" "note")

# Ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

for script in "${scripts[@]}"; do
  src="$SCRIPT_DIR/$script"
  dest="$HOME/.local/bin/$script"

  if [ ! -e "$src" ]; then
    echo "⚠️  Source script '$src' does not exist, skipping..."
    continue
  fi

  if [ -L "$dest" ]; then
    echo "🔗 Link '$dest' already exists, skipping..."
    continue
  fi

  ln -s "$src" "$dest"
  echo "✅ Created symlink: $dest -> $src"
done
