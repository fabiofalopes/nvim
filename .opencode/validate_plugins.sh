#!/bin/bash
# Plugin Validation Script
# Run this to quickly test all plugins

echo "=== Neovim Plugin Validation ==="
echo ""

echo "1. Testing plugin loading..."
nvim --headless +'Lazy load all' +'lua print("✅ All plugins loaded")' +qa 2>&1 | tail -n 1

echo ""
echo "2. Testing Treesitter parsers..."
nvim --headless +'TSInstallInfo' +qa 2>&1 | grep -E "✓|✗" | head -n 5

echo ""
echo "3. Testing Mason LSP servers..."
nvim --headless +'MasonLog' +qa 2>&1 | tail -n 3

echo ""
echo "4. Testing LSP..."
nvim --headless +'lua vim.lsp.start({ name = "test", cmd = {"cat"} })' +qa 2>&1

echo ""
echo "5. Checking for errors in startup..."
nvim --headless +'checkhealth' +qa 2>&1 | grep -i "error" | head -n 5

echo ""
echo "=== Manual Testing Required ==="
echo ""
echo "Open nvim and test interactively:"
echo "  1. File tree:      <C-n>"
echo "  2. Completion:     Type in insert mode, press <C-Space>"
echo "  3. Comment:        gcc"
echo "  4. Auto-close:     Type ( or { in insert mode"
echo "  5. LSP hover:      Press K on a function"
echo "  6. Fuzzy find:     :Files"
echo ""
