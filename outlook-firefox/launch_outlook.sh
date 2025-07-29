#!/bin/bash

# Script to launch Firefox in kiosk mode with a selected profile

URL="https://outlook.live.com/mail/0/inbox/"
PROFILE=""
HELP_MSG="Usage: $0 [--personal | --professional | --help]

Options:
  --personal       Launch Outlook in kiosk mode using the 'Personal' Firefox profile
  --professional   Launch Outlook in kiosk mode using the 'Professional' Firefox profile
  --help           Display this help message"

# Parse arguments
case "$1" in
--personal)
  PROFILE="Personal"
  ;;
--professional | --pro)
  PROFILE="Professional"
  ;;
--help | -h)
  echo "$HELP_MSG"
  exit 0
  ;;
*)
  echo "Error: Invalid option '$1'"
  echo "$HELP_MSG"
  exit 1
  ;;
esac

# Launch Firefox with the selected profile
firefox --new-window -P "$PROFILE" --kiosk "$URL"
