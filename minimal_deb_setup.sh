# Exit if any commnad fails
set -euo pipefail

# Functions
check_command() {
  command -v ${1} >/dev/null 2>&1 || {
    echo -e "Error: ${1} is not installed."
    exit 1
  }
}

# update system
sudo apt update && sudo apt dist-upgrade

# Install packages using pacman
apt_packages=(
  btop eza fzf git gparted kitty less
  man-db micro neofetch neovim stow tldr trash-cli ufw
  wget zoxide zsh
)
install_packages() {
  echo "Installing packages..."
  if ! sudo apt install "${apt_packages[@]}"; then
    echo "Error: Failed to install some packages."
    exit 1
  fi
}

install_packages

# change the default shell
sudo chsh $USER -s /usr/bin/zsh

sudo apt install snapd

sudo systemctl reboot
