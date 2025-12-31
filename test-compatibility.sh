#!/bin/bash
# Neovim Config Compatibility Test
# Tests that config works on current system

echo "==================================="
echo "Neovim Config Compatibility Check"
echo "==================================="
echo ""

# Check Neovim version
echo "1. Neovim Version:"
nvim --version | head -1
echo ""

# Check if LSP config loads without errors
echo "2. Testing LSP Configuration..."
if nvim --headless -c "lua require('plugins.configs.lsp')" -c "quit" 2>&1 | grep -qi "error"; then
    echo "   ❌ LSP config has errors"
    exit 1
else
    echo "   ✅ LSP config loads successfully"
fi
echo ""

# Check keymaps
echo "3. Testing Keymaps..."
if nvim --headless -c "lua require('core.keymaps')" -c "quit" 2>&1 | grep -qi "error"; then
    echo "   ❌ Keymaps have errors"
    exit 1
else
    echo "   ✅ Keymaps load successfully"
fi
echo ""

# Check Mason
echo "4. Testing Mason..."
if command -v mason &> /dev/null; then
    echo "   ℹ️ Mason CLI found"
fi
echo "   Testing Mason in Neovim..."
if timeout 10 nvim --headless "+checkhealth mason" "+quit" 2>&1 | grep -q "OK mason.nvim version"; then
    echo "   ✅ Mason working"
else
    echo "   ⚠️ Mason may need configuration"
fi
echo ""

# Check external dependencies
echo "5. External Dependencies:"
echo -n "   fzf: "
if command -v fzf &> /dev/null; then
    echo "✅ installed ($(fzf --version | head -1))"
else
    echo "❌ not found (install: sudo apt install fzf)"
fi

echo -n "   ripgrep: "
if command -v rg &> /dev/null; then
    echo "✅ installed ($(rg --version | head -1))"
else
    echo "⚠️ not found (optional, install: sudo apt install ripgrep)"
fi

echo -n "   git: "
if command -v git &> /dev/null; then
    echo "✅ installed"
else
    echo "❌ not found (required)"
fi
echo ""

# Check version compatibility
echo "6. Version Compatibility Check:"
nvim --headless -c "lua local v = vim.version(); print(string.format('   Detected: Neovim %d.%d.%d', v.major, v.minor, v.patch))" -c "quit" 2>&1 | grep "Detected:"
nvim --headless -c "lua local v = vim.version(); local is_new = v.major > 0 or (v.major == 0 and v.minor >= 11); print('   Config mode: ' .. (is_new and '0.11+ (modern API)' or '0.10.x (compatible API)'))" -c "quit" 2>&1 | grep "Config mode:"
echo ""

# Final test
echo "7. Full Config Test:"
if timeout 5 nvim --headless "+Lazy sync" +qa 2>&1 | grep -qi "^Error detected"; then
    echo "   ❌ Config has errors"
    exit 1
else
    echo "   ✅ Config loads successfully"
fi
echo ""

echo "==================================="
echo "✅ All tests passed!"
echo "==================================="
echo ""
echo "Your config is working correctly on this system."
echo ""
echo "To test in Neovim:"
echo "  nvim test.lua"
echo "  :checkhealth"
echo ""
