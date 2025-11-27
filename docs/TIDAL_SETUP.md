# TidalCycles Setup Guide for macOS

**Platform:** macOS  
**Neovim Version:** 0.5+  
**Plugin:** vim-tidal  
**Status:** Complete setup instructions

---

## Overview

TidalCycles is a live coding environment for creating musical patterns. It consists of:
- **TidalCycles** (Haskell library) - Pattern language
- **SuperCollider** (Audio synthesis engine) - Sound generation
- **SuperDirt** (SuperCollider quarks) - TidalCycles audio backend
- **vim-tidal** (Neovim plugin) - Editor integration

This guide covers complete setup on macOS.

---

## Prerequisites

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Dependencies
```bash
# Haskell toolchain
brew install ghc cabal-install

# SuperCollider
brew install --cask supercollider

# tmux (for vim-tidal communication)
brew install tmux

# Git (if not already installed)
brew install git
```

---

## Step 1: Install TidalCycles

### Update Cabal package list
```bash
cabal update
```

### Install TidalCycles library
```bash
cabal install tidal --lib
```

### Verify installation
```bash
ghci
```

In ghci, test:
```haskell
:module Sound.Tidal.Context
:t d1
```

Expected output: `d1 :: Pattern ControlMap -> IO ()`

Type `:quit` to exit ghci.

---

## Step 2: Install SuperCollider & SuperDirt

### Launch SuperCollider

```bash
# Option 1: Launch SuperCollider IDE
open /Applications/SuperCollider.app

# Option 2: Use command line (sclang)
sclang
```

### Install SuperDirt Quarks

In SuperCollider IDE or sclang, execute:

```supercollider
// Install SuperDirt
Quarks.install("SuperDirt");

// This will download and install SuperDirt and dependencies
// May take a few minutes
```

After installation, **quit and restart SuperCollider**.

### Boot SuperDirt

In SuperCollider, execute:

```supercollider
// Boot audio server
s.boot;

// Load SuperDirt
SuperDirt.start;
```

**Expected output:** `SuperDirt: listening to Tidal on port 57120`

### Create Boot File (Optional but Recommended)

Create `~/Library/Application Support/SuperCollider/startup.scd`:

```supercollider
(
s.waitForBoot {
    ~dirt = SuperDirt(2, s); // 2 output channels
    ~dirt.loadSoundFiles;
    ~dirt.start(57120, 0 ! 12); // 12 orbits
};
)
```

This automatically boots SuperDirt when SuperCollider starts.

---

## Step 3: Install vim-tidal Plugin

### Using lazy.nvim (Current Setup)

Edit `~/.config/nvim/lua/plugins/init.lua`:

```lua
{
    'tidalcycles/vim-tidal',
    ft = 'tidal',  -- Lazy-load on .tidal files
    config = function()
        require('plugins.configs.tidal').setup()
    end
}
```

**Remove the hardcoded `dir` parameter** - let it install from GitHub.

### Run Plugin Install

```vim
:Lazy sync
```

### Verify Installation

```bash
ls ~/.local/share/nvim/lazy/vim-tidal
```

Should show plugin files.

---

## Step 4: Configure vim-tidal

### Option A: Terminal Mode (Simpler, NeoVim 0.5+)

Edit `~/.config/nvim/lua/plugins/configs/tidal.lua`:

```lua
local M = {}

M.setup = function()
    -- Use built-in terminal
    vim.g.tidal_target = "terminal"
    
    -- Optional: Configure terminal position
    -- "vertical" | "horizontal" | "tab"
    vim.g.tidal_term_type = "vertical"
end

return M
```

### Option B: tmux Mode (Original Setup)

Edit `~/.config/nvim/lua/plugins/configs/tidal.lua`:

```lua
local M = {}

M.setup = function()
    -- Use tmux
    vim.g.tidal_target = "tmux"
    
    -- Configure tmux target
    -- Format: "session:window.pane" or ":window.pane" for current session
    vim.g.tidal_default_config = {
        socket_name = "default",  -- tmux socket name
        target_pane = "{right-of}"  -- Opens pane to the right
    }
end

return M
```

**tmux target formats:**
- `":0.0"` - Window 0, pane 0 in current session
- `":1.0"` - Window 1, pane 0 in current session
- `"{right-of}"` - Create pane to the right (recommended)
- `"{down-of}"` - Create pane below

---

## Step 5: Test the Setup

### Terminal Mode

1. Start Neovim and SuperCollider:
   ```bash
   # Terminal 1: Start SuperCollider
   sclang
   ```
   
   In SuperCollider:
   ```supercollider
   s.boot;
   SuperDirt.start;
   ```
   
   ```bash
   # Terminal 2: Start Neovim
   nvim test.tidal
   ```

2. Create a test file `test.tidal`:
   ```haskell
   d1 $ sound "bd sn"
   ```

3. Press `<C-e>` (Ctrl+E) while on that line

4. Neovim should open a terminal with ghci running TidalCycles

5. You should hear a kick drum and snare pattern

### tmux Mode

1. Start tmux session:
   ```bash
   tmux
   ```

2. Start SuperCollider in a pane:
   ```bash
   sclang
   ```
   
   ```supercollider
   s.boot;
   SuperDirt.start;
   ```

3. Create new pane (`Ctrl+b "`) and start Neovim:
   ```bash
   nvim test.tidal
   ```

4. Test as above with `<C-e>`

---

## Step 6: vim-tidal Keybindings

### Default Keybindings

| Key | Action |
|-----|--------|
| `<C-e>` | Evaluate current line or visual selection |
| `<C-e><C-e>` | Evaluate entire file |
| `<C-h>` | Hush (silence) all patterns |

### Custom Keybindings (Optional)

Add to `~/.config/nvim/lua/core/keymaps.lua`:

```lua
-- TidalCycles keybindings (only loaded for .tidal files)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tidal",
    callback = function()
        local opts = { buffer = true, silent = true }
        
        -- Evaluate paragraph (empty line separated)
        vim.keymap.set('n', '<leader>e', 'vip<C-e>', opts)
        
        -- Hush specific orbit
        vim.keymap.set('n', '<leader>h1', ':TidalSend d1 $ silence<CR>', opts)
        vim.keymap.set('n', '<leader>h2', ':TidalSend d2 $ silence<CR>', opts)
        
        -- Hush all
        vim.keymap.set('n', '<leader>ha', ':TidalHush<CR>', opts)
    end
})
```

---

## Step 7: nvim-cmp Completion (Optional)

To enable TidalCycles autocompletion in nvim-cmp:

### Ensure tidal-completion.lua exists

File should be at: `~/.config/nvim/lua/plugins/configs/tidal-completion.lua`

If not present, create it or use a pre-built completion source from the TidalCycles community.

### Configure in lsp.lua or cmp config

Edit `~/.config/nvim/lua/plugins/configs/lsp.lua`:

```lua
-- Add to nvim-cmp setup
cmp.setup({
    -- ... existing config ...
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'tidal' },  -- Add this
        { name = 'buffer' },
        { name = 'path' },
    },
})
```

---

## Troubleshooting

### Issue: ghci doesn't start or crashes

**Cause:** TidalCycles not properly installed

**Fix:**
```bash
# Reinstall TidalCycles
cabal install tidal --lib --reinstall

# Verify by testing in ghci
ghci
:module Sound.Tidal.Context
```

### Issue: No sound from SuperCollider

**Cause 1:** SuperDirt not started

**Fix:**
```supercollider
// In SuperCollider
s.boot;
SuperDirt.start;
```

**Cause 2:** Audio device issues

**Fix:**
```supercollider
// Check audio devices
ServerOptions.devices;

// Set specific device
Server.default.options.outDevice = "Built-in Output";
s.reboot;
```

### Issue: vim-tidal can't find tmux pane

**Cause:** Incorrect target pane specification

**Fix:**
```lua
-- In tidal.lua, try simpler target
vim.g.tidal_default_config = {
    target_pane = "{right-of}"  -- Let tmux decide
}
```

Or manually specify pane:
```bash
# In tmux, find pane ID
tmux list-panes

# Use format :window.pane
# Example: :0.1 for window 0, pane 1
```

### Issue: `<C-e>` doesn't send code

**Cause 1:** Plugin not loaded

**Fix:**
```vim
:Lazy
# Check if vim-tidal is loaded
```

**Cause 2:** File type not detected

**Fix:**
```vim
:set filetype?
# Should show: filetype=tidal

# If not:
:set filetype=tidal
```

**Cause 3:** Keybinding conflict

**Fix:**
```vim
# Check what <C-e> is mapped to
:map <C-e>
```

---

## Alternative: Using tidalvim script

vim-tidal includes a convenience script:

### Install the script

```bash
cd ~/.local/share/nvim/lazy/vim-tidal
sudo make install
```

This installs:
- `tidal` - Start ghci with Tidal loaded
- `tidalvim` - Start tmux session with Vim and Tidal

### Usage

```bash
# One-command setup
tidalvim
```

This automatically:
1. Creates a tmux session
2. Starts Tidal REPL in one pane
3. Opens Vim in another pane
4. Configures communication

---

## Workflow Examples

### Basic Pattern

```haskell
-- Simple beat
d1 $ sound "bd sn"

-- With more samples
d1 $ sound "bd sd hh sd"

-- Fast pattern
d1 $ fast 2 $ sound "bd sd"

-- Multiple orbits
d1 $ sound "bd sd"
d2 $ sound "hh*8"
d3 $ sound "arpy"

-- Silence an orbit
d1 $ silence

-- Silence everything
hush
```

### Advanced Pattern

```haskell
-- Polyrhythm
d1 $ stack [
    sound "bd*4",
    sound "~ sd",
    sound "hh*8"
]

-- Effects
d1 $ sound "bd sd" # crush "4" # room "0.5"

-- Euclidean rhythm
d1 $ sound "bd(3,8)"
```

---

## Configuration Files Summary

### Minimal Setup (Terminal Mode)

**`lua/plugins/init.lua`:**
```lua
{ 'tidalcycles/vim-tidal', ft = 'tidal' }
```

**`lua/plugins/configs/tidal.lua`:**
```lua
local M = {}
M.setup = function()
    vim.g.tidal_target = "terminal"
end
return M
```

### Advanced Setup (tmux Mode + Completion)

**`lua/plugins/init.lua`:**
```lua
{
    'tidalcycles/vim-tidal',
    ft = 'tidal',
    config = function()
        require('plugins.configs.tidal').setup()
    end
}
```

**`lua/plugins/configs/tidal.lua`:**
```lua
local M = {}

M.setup = function()
    vim.g.tidal_target = "tmux"
    vim.g.tidal_default_config = {
        socket_name = "default",
        target_pane = "{right-of}"
    }
    
    -- Optional: nvim-cmp integration
    local has_cmp, cmp = pcall(require, 'cmp')
    if has_cmp then
        local tidal_source = require('plugins.configs.tidal-completion')
        cmp.register_source('tidal', tidal_source.new())
        
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "tidal",
            callback = function()
                cmp.setup.buffer({
                    sources = {
                        { name = 'tidal', priority = 100 },
                        { name = 'buffer', priority = 50 },
                    }
                })
            end
        })
    end
end

return M
```

---

## Resources

- **TidalCycles:** https://tidalcycles.org/
- **vim-tidal:** https://github.com/tidalcycles/vim-tidal
- **SuperCollider:** https://supercollider.github.io/
- **Community:** https://club.tidalcycles.org/

---

## Current Status in This Config

**Plugin Status:** 🔴 Broken (non-existent path)

**Issues:**
1. Hardcoded `dir` path doesn't exist
2. tmux target may not be correct
3. Completion source untested

**Recommended Fix:**
1. Remove `dir` parameter, use GitHub source
2. Start with terminal mode (simpler)
3. Test basic functionality first
4. Add tmux mode later if preferred
5. Test completion separately

**Quick Fix:**

```bash
# 1. Edit plugin spec
nvim ~/.config/nvim/lua/plugins/init.lua

# 2. Change from:
dir = "/Users/fabiofalopes/Documents/projetos/hub/vim-tidal",

# 3. To:
# (just remove the dir line entirely)

# 4. Save and sync
:Lazy sync

# 5. Test with a .tidal file
```

---

## Next Steps

After setup:
1. ✅ Verify SuperCollider boots properly
2. ✅ Test basic pattern evaluation
3. ✅ Learn TidalCycles syntax
4. ✅ Explore SuperDirt samples
5. ✅ Customize keybindings
6. ✅ Add to your live coding workflow
