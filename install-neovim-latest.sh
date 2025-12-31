#!/bin/bash
# Neovim Latest Stable Installation
# Run this with: bash ~/.config/nvim/install-neovim-latest.sh

set -e

# Configuration
INSTALL_DIR="/opt/nvim"
DOWNLOAD_DIR="/tmp/nvim-install"

echo "======================================"
echo "Neovim Latest Stable Installation"
echo "======================================"
echo ""

# Show current version if installed
if command -v nvim &> /dev/null; then
    echo "Current Neovim version:"
    nvim --version | head -1
    echo ""
fi

# 1. Remove old apt-installed neovim
echo "1. Removing apt-installed neovim..."
sudo apt remove -y neovim 2>/dev/null || true
echo "✅ Done"
echo ""

# 2. Download latest stable release
echo "2. Fetching latest stable release..."
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

# Get latest stable release download URL
LATEST_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | \
    grep "browser_download_url.*nvim-linux64.tar.gz\"" | \
    cut -d '"' -f 4)

echo "   Downloading from: $LATEST_URL"
wget -q --show-progress "$LATEST_URL" -O nvim.tar.gz
echo "✅ Downloaded"
echo ""

# 3. Install to /opt
echo "3. Installing to $INSTALL_DIR..."
sudo rm -rf "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR"
sudo tar xzf nvim.tar.gz --strip-components=1 -C "$INSTALL_DIR"
echo "✅ Installed"
echo ""

# 4. Create symlink in /usr/local/bin
echo "4. Creating symlink..."
sudo ln -sf "$INSTALL_DIR/bin/nvim" /usr/local/bin/nvim
echo "✅ Symlink created"
echo ""

# 5. Cleanup download directory
echo "5. Cleaning up..."
rm -rf "$DOWNLOAD_DIR"
echo "✅ Cleanup complete"
echo ""

# 6. Verify installation
echo "======================================"
echo "✅ Installation Complete!"
echo "======================================"
echo ""
echo "New version:"
nvim --version | head -3
echo ""
echo "Installation details:"
echo "  Binary: $INSTALL_DIR/bin/nvim"
echo "  Symlink: /usr/local/bin/nvim"
echo "  Config: ~/.config/nvim"
echo ""
echo "Test it:"
echo "  nvim"
echo ""
echo "Run config tests:"
echo "  cd ~/.config/nvim && ./test-compatibility.sh"
echo ""
