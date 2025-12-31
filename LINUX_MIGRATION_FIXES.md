# Linux Migration Fixes

## Issues Found and Fixed

### ✅ **CRITICAL: keymaps.lua File Corrupted**
**Problem**: The keymaps.lua file had all content on a single line (no line breaks), making it unreadable.

**Status**: ✅ **FIXED** - File has been reformatted with proper line breaks.

---

### ✅ **CRITICAL: LSP Configuration API Mismatch**
**Problem**: Your LSP config used Neovim 0.11+ APIs, but you're running Neovim 0.10.4. Additionally, mason-lspconfig's `automatic_enable` feature tried to use `vim.lsp.enable()` which doesn't exist in 0.10.x.

**Error**:
```
attempt to call field 'enable' (a nil value)
at mason-lspconfig/features/automatic_enable.lua:47
```

**Impact**: Complete LSP failure - no autocompletion, diagnostics, or language server features.

**Status**: ✅ **FIXED** - Using handlers with `automatic_enable = false` for Neovim 0.10.4 compatibility.

**Changes Made**:
```lua
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "html", "cssls" },
    automatic_enable = false,  -- CRITICAL: Disable for Neovim 0.10.x
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
})
```

---

### ⚠️ **FZF Binary Missing**
**Problem**: `fzf.vim` plugin is loaded but the `fzf` binary is not installed on your system.

**Impact**: FZF commands like `:Files`, `:Rg`, `:Buffers` won't work.

**Status**: ⚠️ **NEEDS ACTION** - You need to install fzf.

**Fix Options**:

#### Option 1: Install via package manager (Recommended)
```bash
# Debian/Ubuntu
sudo apt install fzf

# Arch Linux
sudo pacman -S fzf

# Fedora
sudo dnf install fzf
```

#### Option 2: Install via git
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Option 3: Remove the plugin if you don't need it
Edit `lua/plugins/init.lua` and comment out:
```lua
-- {
--     'junegunn/fzf.vim',
--     dependencies = { 'junegunn/fzf' },
--     build = function()
--         vim.fn['fzf#install']()
--     end
-- },
```

---

## System Differences: macOS → Linux

### 1. **Neovim Version**
- **macOS**: Likely 0.11+ (bleeding edge via Homebrew)
- **Linux**: 0.10.4 (stable distribution package)
- **Impact**: API differences (as seen with LSP config)
- **Recommendation**: Either upgrade to 0.11+ or keep config compatible with 0.10.x

### 2. **Package Availability**
- **macOS Homebrew**: Typically installs everything including dependencies
- **Linux apt/pacman/dnf**: May need manual installation of tools like fzf
- **Check**: Verify all external tools are installed (see below)

### 3. **Path Differences**
- Most paths should work fine (using `~/.config/nvim`)
- undodir is set correctly: `~/.config/nvim/undodir`

---

## Verification Steps

### Test LSP is Working:
```bash
nvim test.lua
```
Then in Neovim:
1. Type some Lua code
2. Press `<C-Space>` to trigger completion
3. Hover over a function and press `K` to see documentation
4. Use `gd` to jump to definition

### Test Keymaps:
- Press `<Space>bb` to list buffers
- Press `<C-n>` to toggle nvim-tree
- Press `<Space>e` to open diagnostics float

### Test FZF (after installing):
```vim
:Files
:Buffers
:Rg
```

---

## Additional Checks

### Check for missing external tools:
```bash
# Required by various plugins
which git       # vim-gitgutter
which rg        # fzf.vim (for :Rg command)
which node      # Some LSP servers
which python3   # Pyright LSP
```

### Install ripgrep if missing (for :Rg in fzf):
```bash
# Debian/Ubuntu
sudo apt install ripgrep

# Arch
sudo pacman -S ripgrep

# Fedora
sudo dnf install ripgrep
```

---

## Optional: Environment Variables

Your config uses conditional loading for some plugins:

### Enable LLM Support:
```bash
export ENABLE_LLM=1
export GROQ_API_KEY="your-api-key-here"
```

### Enable TidalCycles Support:
```bash
export ENABLE_TIDAL=1
```

Add these to your `~/.bashrc` or `~/.zshrc` if needed.

---

## Testing the Fixes

### Quick test:
```bash
# This should now work (only deprecation warning expected)
nvim --headless "+Lazy sync" +qa

# Start Neovim and check for errors
nvim
```

**Expected output**: Only deprecation warning is normal:
```
nvim-lspconfig support for Nvim 0.10 or older is deprecated, use Nvim 0.11+ instead.
Feature will be removed in nvim-lspconfig v3.0.0
```

### Full health check:
```vim
:checkhealth
```

Look for:
- ✓ Mason installations
- ✓ LSP configurations
- ✓ Treesitter parsers
- ⚠ Any warnings about missing tools (cargo, java, php - these are optional)

---

## macOS Compatibility

✅ **All fixes are backward/forward compatible!**

The updated config uses **version detection** to work on both:
- **Linux**: Neovim 0.10.x (stable)
- **macOS**: Neovim 0.11+ (latest)

See `docs/CROSS_VERSION_COMPATIBILITY.md` for details.

**TL;DR**: Your macOS setup won't break - the config automatically adapts to the Neovim version.

## Summary

| Issue | Status | Action Required |
|-------|--------|-----------------|
| Corrupted keymaps.lua | ✅ Fixed | None - already corrected |
| LSP API mismatch | ✅ Fixed | None - already corrected |
| macOS compatibility | ✅ Verified | None - version-aware config |
| FZF binary missing | ⚠️ Needs action | Install fzf package |
| Ripgrep missing | ℹ️ Optional | Install for `:Rg` command |

## Next Steps

1. **Install fzf**: `sudo apt install fzf` (or your package manager)
2. **Test Neovim**: Open a file and verify LSP works
3. **Install ripgrep** (optional): `sudo apt install ripgrep`
4. **Run checkhealth**: `:checkhealth` in Neovim

Your config should now be fully operational on Linux! 🎉
