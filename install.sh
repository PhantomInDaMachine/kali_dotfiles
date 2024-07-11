#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo apt install -y wget curl git thunar

sudo apt install -y flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance rofi unclutter picom 

sudo apt install -y alacritty stow

stow alacritty
stow fehbg
stow i3 
stow picom
stow rofi
stow wallpaper

echo "Done! Grab some wallpaper. To have the wallpaper set on every boot edit ~.fehbg"
echo "After reboot: Select i3 on login, run lxappearance and select arc-dark"
