#!/usr/bin/env bash
set -e

echo "=== NixOS Sway Dotfiles Installer ==="

# Check NixOS
if [ ! -f /etc/NIXOS ]; then
    echo "Error: This does not appear to be NixOS."
    exit 1
fi

# Require root
if [ "$EUID" -ne 0 ]; then
    echo "Run this with sudo:"
    echo "sudo ./install.sh"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Backing up current NixOS config..."

BACKUP="/etc/nixos-backup-$(date +%Y%m%d-%H%M%S)"

cp -r /etc/nixos "$BACKUP"

echo "Backup created at:"
echo "$BACKUP"


echo "Installing configuration..."

cp "$SCRIPT_DIR/configuration.nix" /etc/nixos/configuration.nix

if [ -f "$SCRIPT_DIR/hardware-configuration.nix" ]; then
    cp "$SCRIPT_DIR/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
fi


echo "Enabling flakes..."

mkdir -p /etc/nixos

if ! grep -q "experimental-features" /etc/nixos/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" \
        >> /etc/nixos/nix.conf
fi


echo "Rebuilding NixOS..."

nixos-rebuild switch


echo ""
echo "================================"
echo "Install complete!"
echo "Reboot recommended."
echo "================================"
