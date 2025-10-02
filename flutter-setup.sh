#!/bin/bash

# Define the Flutter SDK URL and download directory
FLUTTER_VERSION="flutter_linux_3.29.2-stable"
DOWNLOAD_DIR="$HOME/Downloads"

FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$FLUTTER_VERSION.tar.xz"
FLUTTER_FILE="$FLUTTER_VERSION.tar.xz"
FLUTTER_DIR="flutter"

# Step 1: Download Flutter SDK to the Downloads folder
echo "Downloading Flutter SDK to $DOWNLOAD_DIR..."
wget $FLUTTER_URL -O $DOWNLOAD_DIR/$FLUTTER_FILE

# Step 2: Extract the downloaded file
echo "Extracting Flutter SDK..."
tar -xvf $DOWNLOAD_DIR/$FLUTTER_FILE -C $DOWNLOAD_DIR

# Step 3: Move the extracted Flutter directory to /usr/bin
echo "Moving Flutter SDK to /usr/bin..."
sudo mv $DOWNLOAD_DIR/$FLUTTER_DIR /usr/bin

# Step 4: Remove the downloaded tar file
echo "Cleaning up the tar file..."
rm $DOWNLOAD_DIR/$FLUTTER_FILE

# Step 5: Add Flutter to the PATH by modifying .zshenv
echo "Adding Flutter to PATH..."
if ! grep -q "export PATH=/usr/bin/flutter/bin:\$PATH" ~/.zshenv; then
  echo "export PATH=/usr/bin/flutter/bin:\$PATH" >>~/.zshenv
else
  echo "Flutter path already exists in .zshenv"
fi

# Step 6: Update Flutter and disable analytics
echo "Upgrading Flutter and disabling analytics..."
flutter upgrade
sleep 1

echo "Disabling Flutter analytics..."
flutter --disable-analytics

echo "Flutter installation and configuration complete!"
