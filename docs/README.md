# Neovim Configuration Documentation

**Last Updated:** Nov 27, 2024 (Profile System Complete)  
**Status:** 🟢 Production Ready  
**Version:** 2.0

---

## 🎯 Start Here

**New user?** Read in this order:
1. **[QUICKSTART.md](./QUICKSTART.md)** - Usage guide with examples
2. **[KEYBINDINGS.md](./KEYBINDINGS.md)** - Key shortcuts reference
3. **[PLUGIN_INVENTORY.md](./PLUGIN_INVENTORY.md)** - What each plugin does

---

## 📚 Documentation Files

### User Guides
- **[QUICKSTART.md](./QUICKSTART.md)** ⭐ **START HERE** - Complete usage guide
  - Profile system (MINIMAL vs FULL)
  - Common workflows (local dev, remote servers)
  - Key bindings overview
  - Troubleshooting
  - Installation instructions

- **[KEYBINDINGS.md](./KEYBINDINGS.md)** - Key shortcuts reference
  - Leader key: Space
  - LSP bindings
  - Navigation
  - Plugin-specific keys

- **[TIDAL_SETUP.md](./TIDAL_SETUP.md)** - TidalCycles live coding setup
  - Prerequisites
  - SuperCollider installation
  - vim-tidal configuration
  - Testing guide

### Technical Reference
- **[PLUGIN_INVENTORY.md](./PLUGIN_INVENTORY.md)** - All 24 plugins explained
  - Core infrastructure
  - UI/Visual
  - LSP/Completion
  - Utilities
  - Status and recommendations

- **README.md** (this file) - Documentation overview

---

## ⚡ Quick Facts

- **Config Age:** ~1 year (modernized Nov 2024)
- **Plugin Count:** 24 (23 active + 1 optional)
- **Profiles:** MINIMAL (12 plugins) | FULL (23 plugins)
- **Status:** 🟢 Production ready, zero critical bugs
- **Documentation:** 5 clean user-facing docs

---

## 🚀 Quick Commands

### Profile Usage
```bash
nvim              # FULL: 23 plugins (local development)
nvim-minimal      # MINIMAL: 12 plugins (remote servers)
nvim-profile      # Check current profile
```

### Inside Neovim
```vim
:Lazy             # Plugin manager
:LspInfo          # LSP status
:Mason            # Install LSP servers
:checkhealth      # System diagnostic
```

### Key Bindings
```
Space           Leader key
Ctrl+n          Toggle file tree
gc              Comment/uncomment
K               LSP hover
Alt+k/j         Move lines
gd              Go to definition
```

---

## 🏗️ Architecture

### Profile System
- **FULL** (23 plugins): Complete development environment with LSP, completion, Git
- **MINIMAL** (12 plugins): Essential editing for servers - fast, lightweight

### Entry Point
```
init.lua
  ├── Bootstrap lazy.nvim
  ├── Set leader key (Space)
  ├── Load core settings (options, keymaps)
  └── Load plugins (profile-aware)
```

### Plugin Distribution
- **Core (12):** File tree, treesitter, theme, airline, commentary, autopairs, fzf, polyglot
- **Full (+11):** LSP, Mason, nvim-cmp (6 sources), Git, plenary
- **Optional:** llm.nvim, vim-tidal (enable with env vars)

---

## 📖 Documentation Structure

```
~/.config/nvim/docs/
├── README.md               # This file - overview
├── QUICKSTART.md           # Complete usage guide ⭐
├── KEYBINDINGS.md          # Key reference
├── PLUGIN_INVENTORY.md     # Plugin catalog
└── TIDAL_SETUP.md          # TidalCycles setup

~/.config/opencode/context/nvim/
└── (Agent session notes and development history)
```

**Note:** Session logs and agent context have been moved to `~/.config/opencode/context/nvim/` to keep this documentation focused on usage rather than development process.

---

## 🔄 Recent Changes (Nov 27, 2024)

### ✅ Completed
- Profile system implemented (MINIMAL/FULL)
- All critical bugs fixed
  - Leader key conflict resolved
  - K keymap collision fixed
  - LSP deprecation warning eliminated
- Documentation reorganized (user docs vs agent context)
- Configuration now production-ready

### 🎯 Features
- Profile-based plugin loading works
- Shell aliases added (nvim-minimal, nvim-full)
- Zero deprecation warnings
- Zero keymap conflicts
- Clean, maintainable codebase

---

## 🔗 External Resources

- **Neovim:** https://neovim.io/
- **lazy.nvim:** https://github.com/folke/lazy.nvim
- **LSP Config:** https://github.com/neovim/nvim-lspconfig
- **TidalCycles:** https://tidalcycles.org/

---

## 💡 Philosophy

> "Keep everything, load intelligently based on context"

This config uses a profile system to load the right tools for the situation:
- **Local workstation?** Full LSP, completion, Git integration
- **Remote server?** Fast, essential editing only

Same codebase, different contexts. Pragmatic, not minimal.

---

**Ready to use!** Start with [QUICKSTART.md](./QUICKSTART.md)
