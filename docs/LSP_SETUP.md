# LSP Setup Guide for Neovim

**Last Updated:** 2025-12-31  
**Configuration File:** `/home/fabio/.config/nvim/lua/plugins/configs/lsp.lua`

---

## Overview

This document provides a comprehensive guide to Language Server Protocol (LSP) setup in your Neovim configuration.

### What is LSP?

**Language Server Protocol (LSP)** is a standard protocol that provides IDE-like features to editors:
- ✅ Code completion (autocomplete)
- ✅ Go to definition
- ✅ Hover documentation
- ✅ Error checking and diagnostics
- ✅ Code actions and refactoring
- ✅ Code formatting

### How It Works

```
┌─────────────┐         ┌──────────────────┐
│   Neovim    │ ◄─────► │  Language Server │
│  (Client)   │   LSP   │  (pyright, etc)  │
└─────────────┘         └──────────────────┘
                              │
                              ▼
                        Analyzes code
                        Provides features
```

---

## Configured Language Servers

### Currently Configured Servers

The following LSP servers are configured in `lua/plugins/configs/lsp.lua`:

| Server | Language | Purpose |
|--------|----------|---------|
| `lua_ls` | Lua | Neovim config editing, Lua development |
| `pyright` | Python | Python development, type checking |
| `html` | HTML | HTML development |
| `cssls` | CSS | CSS development |
| `zls` | Zig | Zig programming language |

### Notable Mention

**`clangd` for C/C++** is **NOT** currently configured but can be easily added (see below).

---

## LSP Configuration

### Configuration File

**Location:** `/home/fabio/.config/nvim/lua/plugins/configs/lsp.lua`

### Key Components

#### 1. Mason Setup

Mason manages LSP server installation:

```lua
require("mason").setup()
```

#### 2. Keymap Configuration

All LSP servers share these keymaps:

| Keymap | Mode | Action |
|--------|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `K` | Normal | Hover documentation |
| `gi` | Normal | Go to implementation |
| `<C-k>` | Insert | Signature help (function parameters) |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `gr` | Normal | Find references |
| `<leader>f` | Normal | Format buffer |

#### 3. Mason-lspconfig

Automatically installs and configures LSP servers:

```lua
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",     -- Lua
        "pyright",    -- Python
        "html",       -- HTML
        "cssls",      -- CSS
        "zls",        -- Zig
    },
})
```

#### 4. nvim-cmp Integration

Provides autocomplete with multiple sources:

```lua
sources = {
    { name = 'nvim_lsp' },  -- LSP completions
    { name = 'luasnip' },   -- Snippet completions
    { name = 'buffer' },    -- Buffer text
    { name = 'path' },      -- File paths
}
```

**Autocomplete Keymaps:**
- `<C-Space>` - Trigger completion
- `<CR>` - Confirm selection
- `<Tab>` - Next item / expand snippet
- `<C-d>` / `<C-f>` - Scroll documentation

---

## Using Language Servers

### Python with pyright

#### Features

- **Type checking** - Catches type errors
- **Autocomplete** - Intelligent code completion
- **Go to definition** - Jump to function/class definitions
- **Import suggestions** - Suggests missing imports
- **Refactoring** - Rename, extract method, etc.

#### Configuration

pyright is configured with default settings:

```lua
{
    capabilities = capabilities,
    on_attach = on_attach,
}
```

#### Usage Examples

**Type checking:**
```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

# Type error caught by pyright:
result = greet(123)  # ❌ Expected str, got int
```

**Autocomplete:**
```python
import os

# Type 'os.path.' and pyright will show all path methods
os.path.join("dir", "file.txt")  # ✅ Shows completions
```

#### Tips

- Create `pyrightconfig.json` in project root for custom settings
- Use virtualenvs for better completion
- Add type hints for better accuracy

### Lua with lua_ls

#### Features

- **Neovim API autocomplete** - `vim.*` commands
- **Lua language support** - Standard Lua APIs
- **Error checking** - Syntax and runtime errors
- **Documentation** - Hover help for functions

#### Configuration

lua_ls uses `.luarc.json` configuration:

```json
{
  "diagnostics": {
    "globals": ["vim"]
  },
  "runtime": {
    "version": "LuaJIT"
  },
  "workspace": {
    "library": [
      "$VIMRUNTIME/lua",
      "${3rd}/luv/library"
    ]
  }
}
```

**Location:** `/home/fabio/.config/nvim/.luarc.json`

#### Usage Examples

**Neovim API autocomplete:**
```lua
vim.opt.number = true      -- ✅ Autocompletes vim.opt.*
vim.keymap.set(...)        -- ✅ Shows keymap options
vim.api.nvim_buf_get_line(...)  -- ✅ Autocompletes API
```

#### Tips

- Keep `.luarc.json` in config directory
- Provides autocomplete for all `vim.*` APIs
- Essential for editing Neovim config

### C/C++ with clangd (Not Currently Configured)

#### Adding clangd

**Step 1: Install via Mason**
```vim
:Mason
```
Search for `clangd` and install.

**Step 2: Configure in lsp.lua**

Add to the `ensure_installed` array:

```lua
ensure_installed = {
    "lua_ls",
    "pyright",
    "html",
    "cssls",
    "zls",
    "clangd",  -- Add this line
},
```

**Step 3: Restart Neovim**

clangd will be automatically configured with the default handler.

#### Features (Once Configured)

- **C/C++ autocomplete** - Complete code, headers, templates
- **Go to definition** - Navigate to definitions
- **Hover docs** - Show function signatures and docs
- **Diagnostics** - Catch compilation errors
- **Code actions** - Fix-its, refactorings
- **Formatting** - clang-format integration

#### Configuration Options

Create `compile_commands.json` for best results:

```json
[
  {
    "directory": "/path/to/project",
    "command": "clang++ -std=c++17 file.cpp",
    "file": "file.cpp"
  }
]
```

Or use CMake to generate:
```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
```

#### Usage Examples

```cpp
#include <iostream>
#include <vector>

// Type 'std::vector' and get completions
std::vector<int> nums = {1, 2, 3};

// Hover over 'push_back' to see docs
nums.push_back(4);
```

#### Tips

- Use `compile_commands.json` for accurate indexing
- Configure `.clang-format` for formatting preferences
- Set up `CMakeLists.txt` for complex projects

---

## LSP Commands

### Built-in Neovim Commands

| Command | Purpose |
|---------|---------|
| `:LspInfo` | Show active LSP servers for current buffer |
| `:LspRestart` | Restart LSP servers for current buffer |
| `:LspStop` | Stop LSP servers for current buffer |
| `:LspStart` | Start LSP servers for current buffer |
| `:Mason` | Open Mason UI to manage servers |
| `:MasonUpdate` | Update all Mason packages |
| `:MasonInstall <server>` | Install specific server |
| `:MasonUninstall <server>` | Uninstall specific server |

### Useful Keymaps Reminder

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `gi` | Go to implementation |
| `<C-k>` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `gr` | Find references |
| `<leader>f` | Format buffer |
| `<C-Space>` | Trigger autocomplete |

---

## Installing Missing Language Servers

### Via Mason (Recommended)

**Method 1: Interactive UI**
```vim
:Mason
```
- Search for server name
- Press `i` to install
- Press `u` to update
- Press `X` to uninstall

**Method 2: Command Line**
```vim
:MasonInstall <server-name>
```

Examples:
```vim
:MasonInstall clangd
:MasonInstall rust-analyzer
:MasonInstall gopls
```

**Method 3: Edit Configuration**

Edit `/home/fabio/.config/nvim/lua/plugins/configs/lsp.lua`:

```lua
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "html",
        "cssls",
        "zls",
        "clangd",        -- Add new servers here
        "rust-analyzer", -- Add new servers here
    },
})
```

Restart Neovim, and Mason will automatically install missing servers.

### Common Language Servers

| Language | Server | Install Command |
|----------|--------|-----------------|
| Rust | rust-analyzer | `:MasonInstall rust-analyzer` |
| Go | gopls | `:MasonInstall gopls` |
| JavaScript/TypeScript | ts_ls | `:MasonInstall ts_ls` |
| C/C++ | clangd | `:MasonInstall clangd` |
| JSON | jsonls | `:MasonInstall jsonls` |
| YAML | yamlls | `:MasonInstall yamlls` |
| Bash | bashls | `:MasonInstall bashls` |

---

## Troubleshooting

### Common Issues

#### 1. LSP Server Not Starting

**Symptoms:** No autocomplete, diagnostics, or `:LspInfo` shows no servers.

**Solutions:**
```vim
" Check if server is installed
:Mason

" Restart LSP
:LspRestart

" Check for errors
:messages

" Verify configuration
:e ~/dotfiles/nvim/lua/plugins/configs/lsp.lua
```

**Common causes:**
- Server not installed via Mason
- File type not associated with server
- Configuration syntax error
- Server command not in PATH

#### 2. No Autocomplete

**Symptoms:** No completions when typing.

**Solutions:**
```vim
" Manually trigger autocomplete
<C-Space>

" Check cmp is loaded
:lua print(vim.inspect(package.loaded['cmp']))

" Verify LSP is attached
:LspInfo
```

**Common causes:**
- nvim-cmp not loaded
- LSP server not attached
- No sources configured
- Buffer not recognized as correct file type

#### 3. Hover Documentation Not Working

**Symptoms:** Pressing `K` does nothing.

**Solutions:**
```vim
" Try explicit command
:lua vim.lsp.buf.hover()

" Check if LSP is attached
:LspInfo

" Verify keymap is set
:map K
```

#### 4. Type Checking Not Working (Python)

**Symptoms:** pyright doesn't show type errors.

**Solutions:**
```vim
" Check pyright is running
:LspInfo

" Restart pyright
:LspRestart

" Create pyrightconfig.json in project root
{
  "typeCheckingMode": "strict"
}
```

**Tips:**
- Add type hints to functions
- Use virtualenvs
- Create `pyrightconfig.json` for project settings

#### 5. Neovim API Autocomplete Not Working (Lua)

**Symptoms:** `vim.*` doesn't autocomplete.

**Solutions:**
```vim
" Check .luarc.json exists
:e ~/.config/nvim/.luarc.json

" Restart lua_ls
:LspRestart

" Verify lua_ls is attached
:LspInfo
```

**Required `.luarc.json`:**
```json
{
  "diagnostics": {
    "globals": ["vim"]
  },
  "workspace": {
    "library": [
      "$VIMRUNTIME/lua"
    ]
  }
}
```

#### 6. clangd Not Working (C/C++)

**Symptoms:** No C/C++ autocomplete or diagnostics.

**Solutions:**
```vim
" Install clangd
:MasonInstall clangd

" Add to ensure_installed
" Edit lsp.lua and add "clangd"
" Restart Neovim

" Check if attached
:LspInfo
```

**For complex projects:**
- Generate `compile_commands.json`
- Use CMake: `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..`

#### 7. Performance Issues

**Symptoms:** Neovim is slow or unresponsive.

**Solutions:**
```vim
" Disable LSP for large files
:LspStop

" Reduce diagnostics
" Create .luarc.json or pyrightconfig.json

" Check server logs
:lua vim.cmd('e ' .. vim.lsp.get_log_path())
```

**Performance tips:**
- Disable unused LSP servers
- Limit file size for LSP
- Use LSP-specific configuration files

#### 8. Configuration Conflicts

**Symptoms:** Keymaps don't work or behave unexpectedly.

**Solutions:**
```vim
" Check keymap definition
:map gd
:map <leader>ca

" Verify no conflicting keymaps
:map

" Check if on_attach is called
" Add to lsp.lua:
print("LSP attached:", server_name)
```

### Getting Help

**Neovim LSP Documentation:**
```vim
:help lsp
:help lspconfig
:help mason.nvim
```

**Check logs:**
```vim
" LSP logs
:lua vim.cmd('e ' .. vim.lsp.get_log_path())

" Mason logs
:lua vim.cmd('e ' .. require('mason-registry.index').get_log_path())
```

**Community resources:**
- Neovim LSP: https://neovim.io/doc/user/lsp.html
- Mason: https://github.com/williamboman/mason.nvim
- nvim-cmp: https://github.com/hrsh7th/nvim-cmp

---

## Quick Reference

### File Locations

| File | Purpose |
|------|---------|
| `~/.config/nvim/lua/plugins/configs/lsp.lua` | Main LSP configuration |
| `~/.config/nvim/.luarc.json` | Lua LSP settings |
| `~/.local/share/nvim/mason/packages/` | Installed LSP servers |

### Essential Commands

```vim
:Mason                    " Manage LSP servers
:LspInfo                  " Show attached servers
:LspRestart               " Restart LSP
:lua vim.lsp.buf.hover()  " Show docs
:lua vim.lsp.buf.format() " Format code
```

### Essential Keymaps

```vim
gd          " Go to definition
K           " Hover documentation
<leader>ca  " Code actions
<leader>f   " Format buffer
<leader>rn  " Rename symbol
gr          " Find references
```

---

## Advanced Configuration

### Custom Server Configuration

To configure specific LSP servers differently, add a custom handler:

```lua
handlers = {
    -- Python with custom settings
    pyright = function()
        require("lspconfig")["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "strict",
                    }
                }
            }
        })
    end,
    
    -- Default handler for other servers
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
```

### Disabling LSP for Specific File Types

```vim
autocmd FileType markdown lua vim.lsp.stop_client(vim.lsp.get_active_clients())
```

### Root Directory Configuration

LSP servers detect project roots via these markers:

```lua
root_markers = {
    ".git",           -- Git repository
    "package.json",   -- Node.js
    "pyproject.toml", -- Python
    "Cargo.toml",     -- Rust
    "CMakeLists.txt", -- C/C++
}
```

---

## Summary

### Key Points

1. **LSP provides IDE-like features** in Neovim
2. **Mason manages LSP server installation**
3. **All servers share common keymaps** (gd, K, <leader>ca, etc.)
4. **lua_ls needs .luarc.json** for Neovim API completion
5. **clangd needs to be added** for C/C++ support
6. **Troubleshoot with :LspInfo** and check logs

### Getting Started

1. Open a Python, Lua, HTML, CSS, or Zig file
2. Check `:LspInfo` to verify server is attached
3. Try keymaps: `gd` for definition, `K` for hover
4. Use `<C-Space>` for autocomplete
5. Install missing servers with `:Mason`

### Next Steps

- Add `clangd` for C/C++ development
- Configure project-specific settings (pyrightconfig.json, etc.)
- Explore code actions with `<leader>ca`
- Customize keymaps as needed

---

**For more information, see:**
- `:help lsp` - Neovim LSP documentation
- `:help mason.nvim` - Mason documentation
- `/home/fabio/.config/nvim/docs/LSP_CONFIGURATION_GUIDE.md` - Detailed LSP configuration guide
