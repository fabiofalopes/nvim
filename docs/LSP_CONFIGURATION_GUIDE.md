# Understanding .luarc.json & LSP Configuration

**Created:** Nov 27, 2024  
**Purpose:** Explain LSP configuration and potential TidalCycles autocomplete setup

---

## What is `.luarc.json`?

### Simple Explanation

`.luarc.json` is a **configuration file** for the **Lua Language Server** (lua_ls). It tells the LSP how to understand your Lua code.

**Think of it like a reference manual:**
- Without it: LSP doesn't know Neovim-specific APIs
- With it: LSP understands `vim.*` commands and provides autocomplete

### What It Does

```json
{
  "diagnostics": {
    "globals": ["vim"]         // "vim" is not undefined, it's a Neovim global
  },
  "runtime": {
    "version": "LuaJIT"        // Use LuaJIT (Neovim's Lua), not standard Lua
  },
  "workspace": {
    "library": [
      "$VIMRUNTIME/lua",       // Load Neovim's built-in Lua APIs
      "${3rd}/luv/library",    // libuv bindings
      "${3rd}/busted/library"  // Testing framework
    ]
  }
}
```

### Why We Added It

**Problem:**
```lua
vim.opt.number = true    -- ❌ Warning: "Undefined global 'vim'"
vim.keymap.set(...)      -- ❌ Warning: "Undefined global 'vim'"
```

**Solution:**
- Created `.luarc.json`
- Told Lua LSP: "Hey, `vim` is provided by Neovim"
- Now get autocomplete for `vim.opt.*`, `vim.keymap.*`, etc.

---

## LSP: The Bigger Picture

### What is an LSP?

**Language Server Protocol** = A standard way for editors to get:
- Autocomplete
- Go to definition
- Error checking
- Documentation on hover
- Code formatting

### How It Works

```
┌─────────────┐         ┌──────────────────┐
│   Neovim    │ ◄─────► │  Language Server │
│  (Client)   │   LSP   │   (lua_ls, etc)  │
└─────────────┘         └──────────────────┘
                              │
                              ▼
                        Analyzes code
                        Provides completions
                        Finds errors
```

### LSP Servers We Have

**Currently configured in `lua/plugins/configs/lsp.lua`:**

1. **lua_ls** - Lua (configured via `.luarc.json`)
2. **pyright** - Python
3. **ts_ls** - TypeScript/JavaScript
4. **html** - HTML
5. **cssls** - CSS

**Managed by:** Mason (`:Mason` to install/manage)

---

## TidalCycles & LSP: The Challenge

### Current Situation

**TidalCycles = Haskell DSL (Domain Specific Language)**

When you write:
```haskell
d1 $ sound "bd sn"
```

This is **Haskell code**, not a separate language.

### Why No Autocomplete?

**We only have vim-tidal plugin, which provides:**
- ✅ Syntax highlighting
- ✅ Code evaluation (send to SuperCollider)
- ✅ GHCI integration
- ❌ No autocomplete
- ❌ No type hints
- ❌ No documentation on hover

**Reason:** We need a **Haskell LSP**, not a TidalCycles LSP.

---

## Research Findings: TidalCycles Autocomplete

### Option 1: Haskell Language Server (HLS)

**What is it?**
- Official Haskell LSP implementation
- Provides autocomplete, type hints, errors
- Works with any Haskell code (including Tidal)

**Status:**
- ✅ Exists and is mature
- ✅ Used by TidalCycles community
- ⚠️ Complex to set up
- ⚠️ Requires matching GHC version

**Links:**
- GitHub: https://github.com/haskell/haskell-language-server
- Docs: https://haskell-language-server.readthedocs.io/

### Option 2: Tidal-Specific Autocomplete

**Community Discussion:**
- People have tried using HLS with Tidal
- Mixed results reported
- No official TidalCycles LSP exists
- Most Tidal users don't use autocomplete

**TidalCycles Club Threads:**
- "Language server protocol" discussion (2020)
- "Emacs autocomplete" thread
- General consensus: It's possible but not essential

### Option 3: Alternative Neovim Plugins

**Found in research:**

1. **cycles.nvim** (by zuloo)
   - https://github.com/zuloo/cycles.nvim
   - Opinionated Tidal plugin
   - Better GHCI integration
   - Still no autocomplete

2. **tidal.nvim** (by grddavies)
   - https://github.com/grddavies/tidal.nvim
   - Alternative to vim-tidal
   - Modern Lua implementation
   - Still no autocomplete

---

## How to Add LSP Servers (General)

### Method 1: Via Mason (Recommended)

```vim
:Mason                    " Open Mason UI
" Search for language server
" Press 'i' to install
```

### Method 2: Via Configuration

Edit `lua/plugins/configs/lsp.lua`:

```lua
-- Add new server
vim.lsp.config('new_server_name', {
  cmd = { 'language-server-command' },
  filetypes = { 'filetype' },
  root_markers = { '.git' },
})

vim.lsp.enable('new_server_name')
```

### Method 3: Via Mason-lspconfig

Edit `lua/plugins/configs/lsp.lua`:

```lua
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'pyright',
    'ts_ls',
    'html',
    'cssls',
    'new_server_name',  -- Add here
  },
})
```

---

## Adding Haskell LSP for TidalCycles

### Prerequisites

1. **Install GHCup** (Haskell toolchain manager)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
   ```

2. **Install Haskell Language Server**
   ```bash
   ghcup install hls
   ```

3. **Verify installation**
   ```bash
   which haskell-language-server-wrapper
   ```

### Configure in Neovim

**Add to `lua/plugins/configs/lsp.lua`:**

```lua
-- Haskell Language Server for TidalCycles
vim.lsp.config('hls', {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell', 'lhaskell', 'tidal' },
  root_markers = {
    'hie.yaml',
    'stack.yaml',
    'cabal.project',
    'package.yaml',
    '.git',
  },
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
    },
  },
})

vim.lsp.enable('hls')
```

**Create `.luarc.json` equivalent for Haskell (hie.yaml):**

```bash
cd ~/.config/nvim
cat > hie.yaml << EOF
cradle:
  direct:
    arguments:
      - -i
      - /path/to/tidal/libraries
EOF
```

### Challenges

**Why this is complex:**

1. **GHC Version Matching**
   - HLS must match your TidalCycles GHC version
   - TidalCycles might use different GHC than system

2. **Tidal as Library**
   - TidalCycles isn't a standalone language
   - It's a Haskell library imported in GHCI
   - HLS needs to know where Tidal is installed

3. **Live Coding Context**
   - Most Tidal code is ephemeral (live coding)
   - Autocomplete might be overkill for improvisation
   - Community doesn't prioritize this feature

---

## Recommendations

### For Now (Keep It Simple)

**Don't add Haskell LSP yet** because:
- ❌ Complex setup (GHC versions, hie.yaml, etc.)
- ❌ High maintenance (breaks with Tidal updates)
- ❌ Questionable value (live coding = fast iteration, not autocomplete)
- ✅ vim-tidal works fine for evaluation

**Current setup is good for TidalCycles:**
- vim-tidal handles code evaluation
- Syntax highlighting works
- SuperCollider integration works
- You can look up docs manually

### Future Enhancement (If Desired)

**If you want autocomplete later:**

1. **Install via Mason**
   ```vim
   :Mason
   " Search: hls
   " Install: haskell-language-server
   ```

2. **Configure for Tidal**
   - Create `hie.yaml` in Tidal projects
   - Point to Tidal library location
   - Test with simple Haskell files first

3. **Alternative: Try cycles.nvim**
   - Modern Lua plugin
   - Better GHCI integration
   - Might have better autocomplete support

---

## Comparison: Languages with Good LSP Support

### Python (pyright)
- ✅ Excellent autocomplete
- ✅ Type hints
- ✅ Import suggestions
- ✅ Easy to set up

### TypeScript (ts_ls)
- ✅ Amazing autocomplete
- ✅ Type checking
- ✅ Refactoring tools
- ✅ Works out of the box

### Haskell (hls)
- ⚠️ Good autocomplete (when configured)
- ⚠️ Type hints work well
- ❌ Complex setup
- ❌ GHC version matching issues

### TidalCycles (none)
- ❌ No dedicated LSP
- ⚠️ Can use Haskell LSP (with effort)
- 🤷 Community doesn't prioritize it
- ✅ vim-tidal is sufficient for most users

---

## Key Takeaways

### Understanding `.luarc.json`

1. **It's a config file** for Lua LSP (lua_ls)
2. **Not a folder**, not an LSP server itself
3. **Tells LSP:** "Understand Neovim's `vim` global"
4. **Provides:** Autocomplete for `vim.*` APIs
5. **Keep it:** Makes editing config much nicer

### Understanding LSP in General

1. **LSP = Protocol** for editor ↔ language server communication
2. **Language Server = Program** that analyzes code
3. **Each language needs** its own language server
4. **Mason manages** language server installation
5. **`lsp.lua` configures** which servers to use

### TidalCycles Situation

1. **TidalCycles = Haskell DSL**, not separate language
2. **No dedicated Tidal LSP** exists
3. **Haskell LSP (HLS)** can work, but complex setup
4. **Current vim-tidal** is sufficient for live coding
5. **Autocomplete not essential** for improvisation

### What to Do

**Now:**
- ✅ Keep `.luarc.json` (helps with Lua config editing)
- ✅ Current LSP setup works great (Lua, Python, TS, etc.)
- ✅ vim-tidal is good enough for TidalCycles

**Future (Optional):**
- 🔮 Install HLS if you want Haskell autocomplete
- 🔮 Try cycles.nvim or tidal.nvim alternatives
- 🔮 Create hie.yaml for Tidal project setup

---

## Resources

### Documentation
- LSP Specification: https://microsoft.github.io/language-server-protocol/
- Haskell Language Server: https://haskell-language-server.readthedocs.io/
- TidalCycles Vim Plugin: https://github.com/tidalcycles/vim-tidal

### Community
- TidalCycles Club (LSP discussion): https://club.tidalcycles.org/t/language-server-protocol/1525
- Neovim LSP Config: `:help lsp`
- Mason Documentation: `:help mason.nvim`

### Alternatives
- cycles.nvim: https://github.com/zuloo/cycles.nvim
- tidal.nvim: https://github.com/grddavies/tidal.nvim

---

**Bottom Line:** Your `.luarc.json` is perfectly fine and should stay. TidalCycles autocomplete is possible but complex and not necessary. Focus on making music, not fighting with LSP configs! 🎵
