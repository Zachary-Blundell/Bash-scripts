#!/bin/bash
CHATGPT="https://chatgpt.com/"
OUTLOOK="https://outlook.live.com/mail/0/inbox/"
DEEPL="https://www.deepl.com/en/translator#en/fr/"

hyprctl keyword exec [workspace 2] "brave --new-window $CHATGPT $OUTLOOK $DEEPL"
