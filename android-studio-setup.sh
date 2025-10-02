#!/bin/bash

# Define the Android Studio version and download URL
ANDROID_STUDIO_VERSION="android-studio-2023.2.1.24-linux"
DOWNLOAD_DIR="$HOME/Downloads"
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2023.2.1.24/$ANDROID_STUDIO_VERSION.tar.gz"
ANDROID_STUDIO_FILE="$ANDROID_STUDIO_VERSION.tar.gz"
ANDROID_STUDIO_DIR="android-studio"

# Step 1: Download Android Studio to the Downloads folder
echo "Downloading Android Studio to $DOWNLOAD_DIR..."
wget $ANDROID_STUDIO_URL -O $DOWNLOAD_DIR/$ANDROID_STUDIO_FILE

# Step 2: Extract the downloaded file
echo "Extracting Android Studio..."
tar -xvzf $DOWNLOAD_DIR/$ANDROID_STUDIO_FILE -C $DOWNLOAD_DIR

# Step 3: Move the extracted Android Studio directory to /usr/bin
echo "Moving Android Studio to /usr/bin..."
sudo mv $DOWNLOAD_DIR/$ANDROID_STUDIO_DIR /usr/bin/

# Step 4: Remove the downloaded tar file
echo "Cleaning up the tar file..."
rm $DOWNLOAD_DIR/$ANDROID_STUDIO_FILE

# Step 5: Add Android Studio to the PATH by modifying .zshenv
echo "Adding Android Studio to PATH..."
if ! grep -q "export PATH=/usr/bin/android-studio/bin:\$PATH" ~/.zshenv; then
  echo "export PATH=/usr/bin/android-studio/bin:\$PATH" >>~/.zshenv
else
  echo "Android Studio path already exists in .zshenv"
fi

# Step 6: Start Android Studio and show instructions
echo "Starting Android Studio..."
cd /usr/bin/android-studio/bin && ./studio.sh &
zenity --info --title="Android Studio Setup Instructions" \
  --text="Android Studio has started! Please follow these steps after it starts:

1. Download the SDK Command-line Tools
  1. More Actions > SDK Manager > Android SDK (defualt selection) > SDK Tools
  2. Check the Android SDK Command-line Tools
  3. Hit apply
2. Add desktop launcher

" &

# Step 7: Wait for Android Studio to close
wait $!

# After Android Studio is closed, continue with the rest of the setup
echo "Android Studio has been closed. Continuing with the rest of the setup..."

# Step 7: Android Studio Configuration (SDK, licenses)
echo "Configuring Android Studio..."
flutter doctor --android-licenses
yes | flutter doctor --android-licenses

# Step 8: Make Chromium the default browser for Flutter
echo "Setting Chromium as the default browser for Flutter..."
export CHROME_EXECUTABLE=/usr/bin/chromium

# Final Step: Run flutter doctor to check everything is set up
echo "Running flutter doctor..."
flutter doctor

echo "Android Studio installation and configuration complete!"
