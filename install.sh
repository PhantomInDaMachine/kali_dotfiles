#!/bin/bash set -euo pipefail

# Colors
OK="$(tput setaf 2 bold)[OK]"
ERROR="$(tput setaf 1 bold)[ERROR]"
WARN="$(tput setaf 5 bold)[WARN]"
CAT="$(tput setaf 6 bold)[ACTION]"
RESET="$(tput sgr0)"

RED=$(tput setaf 203 bold)
CYAN=$(tput setaf 6 bold)
MAUVE="\e[38;2;203;166;247;1m"

LOG_FILE='myname.out'
BIN_PATH='/usr/local/bin'

# Check if running as root
if [[ $EUID -eq 0 ]]; then
  echo -e "${ERROR} This script should not be executed as root! Exiting...${RESET}"
  exit 1
fi

clear

# Welcome message
WELCOME="${CYAN}"
echo "$WELCOME"  
echo
echo -e "${RED}Welcome to myname's Kali-vm Install Script!${RESET}"
echo
echo -e "${RED}ATTENTION: ${MAUVE}Run a full system update and reboot first! (Highly Recommended)${RESET}"
echo
echo -e "${RED}NOTE: ${CYAN}After installation, all outputs and errors are saved to '$LOG_FILE'.${RESET}"
echo
echo -e "${RED}NOTE: ${CYAN}If you are installing on a VM, enable 3D acceleration to avoid issues.${RESET}"
echo

read -p "${CYAN}Would you like to proceed? (y/n): ${RESET}" proceed
if [[ $proceed != "y" ]]; then
  echo "Installation aborted."
  exit 1
fi

# Helper functions
colorize_prompt() {
  local color="$1"
  local message="$2"
  echo -e "${color} ${message}${RESET}"
  echo -e "${color} ${message}${RESET}" >> "$LOG_FILE"
}

cmd_exec() {
  colorize_prompt "${RED}" "Executing: $*"
  if ! "$@" >> "$LOG_FILE" 2>&1; then
    colorize_prompt "${ERROR}" "Command '$*' failed to execute."
    return 1
  fi
}   

echo -e "$WELCOME\n\n" > "$LOG_FILE"

# Check sudo privileges
if sudo -n true 2>/dev/null; then
  colorize_prompt "${OK}" "Sudo privileges detected."
elif sudo -v; then
  colorize_prompt "${CAT}" "Password accepted. Granting sudo permissions."
else
  colorize_prompt "${ERROR}" "Sudo privileges not granted."
  exit 1
fi

# Install dependencies
colorize_prompt "${CAT}" "Installing packages and dependencies..."
cmd_exec sudo apt update
cmd_exec sudo apt-get install -y \
  alacritty \
  stow \
  flameshot \
  feh \
  i3 \
  lxappearance \
  rofi \
  unclutter-xfixes \
  picom \
  wget \
  curl \
  git \
  thunar \
  zsh \
  python3 \
  python3-venv \
  python3-pip \
  polybar \
  kitty \
  unzip \
  zoxide \
  betterlockscreen \
  bat \
  fzf \
  tmux \
  ripgrep \
  xclip \
  eza \
  starship \
  neovim \
  qbittorrent \

# GreenClip
if [ ! -f "$BIN_PATH/greenclip" ]; then
    colorize_prompt "${CAT}" "Installing GreenClip..."
    if cmd_exec wget -q -O /tmp/greenclip https://github.com/erebe/greenclip/releases/download/v4.2/greenclip; then
        chmod +x /tmp/greenclip
        sudo mv /tmp/greenclip "$BIN_PATH/greenclip"
        colorize_prompt "${OK}" "GreenClip installed successfully."
    else
        colorize_prompt "${ERROR}" "GreenClip installation failed."
        exit 1
    fi
fi   

# Dotfiles and scripts
colorize_prompt "${CAT}" "Copying configuration files..."
if ! stow -S -t $HOME alacritty kitty fehbg i3 picom KG_rofi KG_polybar wallpaper starship tmux zshrc Jazzpizazz greenclip nvchad; then
    colorize_prompt "${ERROR}" "Stow failed. Check that all directories exist."
    exit 1
fi   

mkdir -p ~/Pictures/screenshots #FlameShot

# Configure Betterlockscreen 
colorize_prompt "${CAT}"  "Configuring betterlockscreen..."
cmd_exec betterlockscreen -u ~/.wallpaper/galaxy-night-view.jpg

# Final cleanup and reboot prompt
cmd_exec sudo apt autoremove -y
clear

colorize_prompt "${MAUVE}" "myname installation completed!"

read -p "${CAT} Would you like to reboot now? (y/n): " reboot_ans
if [[ $reboot_ans =~ ^[Yy]$ ]]; then
  sudo reboot
else
  colorize_prompt "${MAUVE}" "Manual reboot required."
fi
