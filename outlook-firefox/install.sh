#!/bin/bash

set -e

# Define paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
ICON_DIR="$HOME/.local/share/icons"
DESKTOP_DIR="$HOME/.local/share/applications"

# Create required directories
mkdir -p "$BIN_DIR" "$ICON_DIR" "$DESKTOP_DIR"

echo "Creating symbolic link to launch script in $BIN_DIR..."
ln -sf "$SCRIPT_DIR/launch_outlook.sh" "$BIN_DIR/launch_outlook"

echo "Copying icons to $ICON_DIR..."
cp "$SCRIPT_DIR/outlook.png" "$ICON_DIR/"
cp "$SCRIPT_DIR/outlook_pro.png" "$ICON_DIR/"

echo "Creating .desktop entries..."

# Personal profile desktop entry
cat >"$DESKTOP_DIR/outlook-kiosk-personal.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Outlook (Personal)
Comment=Launch Outlook in Firefox Kiosk Mode with Personal Profile
Exec=launch_outlook --personal
Icon=outlook
Terminal=false
Categories=Network;Email;
StartupNotify=false
EOF

# Professional profile desktop entry
cat >"$DESKTOP_DIR/outlook-kiosk-professional.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Outlook (Professional)
Comment=Launch Outlook in Firefox Kiosk Mode with Professional Profile
Exec=launch_outlook --professional
Icon=outlook_pro
Terminal=false
Categories=Network;Email;
StartupNotify=false
EOF

# Make desktop files executable
chmod +x "$DESKTOP_DIR/outlook-kiosk-"*.desktop

echo "Installation complete!"
echo "You can now search for 'Outlook' in your application launcher."
