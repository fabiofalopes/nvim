#!/bin/bash
# Test Profile System

echo "==================================="
echo "Neovim Profile System Test"
echo "==================================="
echo ""

echo "1. Testing FULL profile (default)..."
nvim --headless +'lua print("Profile: " .. (vim.env.NVIM_PROFILE or "full (default)"))' +qa 2>&1 | grep "Profile:"

echo ""
echo "2. Testing MINIMAL profile..."
NVIM_PROFILE=minimal nvim --headless +'lua print("Profile: " .. vim.env.NVIM_PROFILE)' +qa 2>&1 | grep "Profile:"

echo ""
echo "3. Checking plugin counts..."
echo "   Expected: CORE = 11 plugins, FULL = 11 + 12 = 23 plugins"
echo ""
echo "   FULL profile plugin count:"
nvim --headless +'lua local c = #require("plugins.core"); local f = #require("plugins.full"); print("  CORE: " .. c .. " specs, FULL: " .. f .. " specs, Total: " .. (c+f))' +qa 2>&1 | grep -E "CORE|FULL|Total"

echo ""
echo "   MINIMAL profile plugin count:"
NVIM_PROFILE=minimal nvim --headless +'lua local c = #require("plugins.core"); print("  CORE only: " .. c .. " specs")' +qa 2>&1 | grep "CORE"

echo ""
echo "4. Manual verification needed:"
echo "   Open nvim and run :Lazy to see loaded plugins"
echo ""
echo "   Test FULL:"
echo "     nvim"
echo "     :Lazy"
echo "     (Should see LSP plugins: mason, nvim-cmp, etc.)"
echo ""
echo "   Test MINIMAL:"
echo "     NVIM_PROFILE=minimal nvim"
echo "     :Lazy"
echo "     (Should NOT see LSP plugins)"
echo ""
echo "==================================="
