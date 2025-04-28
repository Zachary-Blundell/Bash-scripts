#!/bin/bash

go-edit() {
  # if it is a directory
  if [ -d "$1" ]; then
    cd "$1"
    $EDITOR .
    cd "$OLDPWD"
  else # if it is a file
    $EDITOR "$1"
  fi

}

## Edit Configs
# Edit this .zshrc file
go-edit '/home/zaiquiri/Code/dutch.lua'

# alias ezsh='$EDITOR ~/.config/zshrc; source ~/.zshrc'
# alias ez='$EDITOR ~/.config/zshrc; source ~/.zshrc'
# alias rzsh='source ~/.zshrc'
