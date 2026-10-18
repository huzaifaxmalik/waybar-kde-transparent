#!/usr/bin/env bash
set -e
DIR="$HOME/.config/waybar"

echo "==> Installing packages"
sudo pacman -S --needed waybar qt6-tools ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

fc-cache -f

echo "==> Copying config"
mkdir -p "$DIR/scripts" "$HOME/.config/autostart"
cp config.jsonc style.css "$DIR/"
cp scripts/*.sh "$DIR/scripts/"
chmod +x "$DIR"/scripts/*.sh

echo "==> Autostart with Plasma"
cat > "$HOME/.config/autostart/waybar.desktop" <<DESK
[Desktop Entry]
Type=Application
Name=Waybar
Exec=waybar
X-KDE-autostart-phase=2
DESK

echo "==> Done. Run 'pkill waybar; waybar &' to try it now."
