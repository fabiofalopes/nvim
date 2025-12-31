#!/bin/bash
# Install Missing Neovim Dependencies

echo "======================================"
echo "Installing Neovim Dependencies"
echo "======================================"
echo ""

echo "Installing fzf and ripgrep..."
sudo apt update
sudo apt install -y fzf ripgrep

echo ""
echo "======================================"
echo "✅ Installation Complete!"
echo "======================================"
echo ""

# Verify
echo "Installed versions:"
echo "  fzf: $(fzf --version | head -1)"
echo "  ripgrep: $(rg --version | head -1)"
echo ""

echo "Test in Neovim:"
echo "  :Files    - Fuzzy find files"
echo "  :Rg       - Search content with ripgrep"
echo "  :Buffers  - List open buffers"
echo ""

# Run compatibility test again
echo "Running compatibility test..."
echo ""
cd ~/.config/nvim && ./test-compatibility.sh
