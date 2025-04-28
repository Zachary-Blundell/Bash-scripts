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
sudo pacman -Syu

# Update mirros
sudo pacman -S --needed reflector

check_command reflector
reflector --country 'France, Germany,'

# Install packages using pacman
pacman_packages=(
  btop eza fzf git gparted intel-ucode kitty less lib32-vulkan-radeon
  man-db micro neofetch neovim pika-backup starship stow tldr trash-cli ufw
  vim vulkan-radeon wget zellij zoxide zsh
)
install_packages() {
  echo "Installing packages..."
  if ! sudo pacman -S --needed "${pacman_packages[@]}"; then
    echo "Error: Failed to install some packages."
    exit 1
  fi
}

install_packages

# change the default shell
sudo chsh $USER -s /usr/bin/zsh

## DOTFILES
cd $HOME
git clone https://github.com/Zachary-Blundell/dotfiles.git
cd dotifles

## Fonts %%{{{
sudo pacman -S --needed ttf-bigblueterminal-nerd ttf-profont-nerd
