# Plugin Inventory

**Last Updated:** Nov 26, 2024  
**Total Plugins:** 26 active + 2 commented

---

## Legend

- 🟢 **Essential** - Core functionality, needed for basic usage
- 🔵 **Enhanced** - Improves workflow significantly
- 🟡 **Optional** - Nice to have, not critical
- 🟠 **Experimental** - Testing/evaluation phase
- 🔴 **Broken** - Currently non-functional
- ⚪ **Deprecated** - Should be removed

---

## Core Infrastructure (4)

### 🟢 lazy.nvim
**What:** Plugin manager  
**Why:** Modern, fast, lazy-loading capabilities  
**Status:** ✅ Working  
**Keep?** Yes - Essential  
**Notes:** Bootstrapped in init.lua

### 🟢 nvim-treesitter  
**What:** Advanced syntax parsing & highlighting  
**Why:** Better than regex-based syntax, enables advanced features  
**Status:** ✅ Working  
**Keep?** Yes - Essential  
**Config:** `lua/plugins/configs/treesitter.lua`  
**Notes:** Build step runs `:TSUpdate`

### 🟢 nvim-tree.lua
**What:** File explorer sidebar  
**Why:** Navigate project structure visually  
**Status:** ✅ Working  
**Keep?** Yes - Essential  
**Toggle:** `<C-n>`  
**Config:** `lua/plugins/configs/nvimtree.lua`  
**Notes:** Replaced NERDTree (good move)

### 🟢 nvim-web-devicons
**What:** Icons for files/folders  
**Why:** Visual clarity in file tree  
**Status:** ✅ Working  
**Keep?** Yes - Dependency of nvim-tree  

---

## UI & Visual (4)

### 🔵 onedark.nvim
**What:** OneDark colorscheme (Lua-native)  
**Why:** Popular, pleasant colorscheme  
**Status:** ✅ Working  
**Keep?** Yes  
**Style:** 'darker'  
**Notes:** Consider trying other themes later

### 🔵 vim-airline
**What:** Status line with info  
**Why:** Shows mode, file, git branch, etc.  
**Status:** ✅ Working  
**Keep?** Yes (or consider lualine.nvim for pure Lua)  
**Theme:** 'luna'  
**Notes:** Vimscript plugin, consider migration to lualine

### 🔵 vim-airline-themes
**What:** Theme collection for airline  
**Why:** Dependency for vim-airline  
**Status:** ✅ Working  
**Keep?** If keeping vim-airline

### 🟡 vim-polyglot
**What:** Language pack (syntax, indentation for 600+ languages)  
**Why:** Broad language support  
**Status:** ⚠️ Potentially Redundant  
**Keep?** Maybe - may overlap with treesitter  
**Notes:** **Review:** Treesitter may cover most use cases. Test without it.

---

## LSP & Completion (10)

### 🟢 nvim-lspconfig
**What:** LSP client configuration  
**Why:** Language Server Protocol support (autocomplete, diagnostics, go-to-def)  
**Status:** ✅ Working  
**Keep?** Yes - Essential for IDE features  
**Config:** `lua/plugins/configs/lsp.lua`

### 🟢 mason.nvim
**What:** LSP/DAP/Linter installer  
**Why:** Easy management of language servers  
**Status:** ✅ Working  
**Keep?** Yes - Essential  
**Servers Installed:** lua_ls, pyright, html, cssls

### 🟢 mason-lspconfig.nvim
**What:** Bridge between mason & lspconfig  
**Why:** Auto-setup of installed servers  
**Status:** ✅ Working  
**Keep?** Yes - Essential

### 🟢 nvim-cmp
**What:** Completion engine  
**Why:** Popup menu for autocompletion  
**Status:** ✅ Working  
**Keep?** Yes - Essential  
**Mappings:** Tab (next), CR (confirm), C-Space (trigger)

### 🟢 cmp-nvim-lsp
**What:** LSP completion source for nvim-cmp  
**Why:** Shows LSP suggestions in completion menu  
**Status:** ✅ Working  
**Keep?** Yes - Essential

### 🟡 cmp-buffer
**What:** Buffer word completion source  
**Why:** Suggests words from open buffers  
**Status:** ✅ Working  
**Keep?** Yes - Useful

### 🟡 cmp-path
**What:** File path completion source  
**Why:** Autocomplete file paths  
**Status:** ✅ Working  
**Keep?** Yes - Useful

### 🔵 LuaSnip
**What:** Snippet engine  
**Why:** Code snippets (e.g., `for` → full loop structure)  
**Status:** ✅ Working  
**Keep?** Yes - Productivity boost  
**Notes:** Need to add/customize snippets

### 🔵 cmp_luasnip
**What:** LuaSnip completion source  
**Why:** Shows snippets in completion menu  
**Status:** ✅ Working  
**Keep?** Yes - Dependency

### 🔵 nvim-nio
**What:** Async I/O library  
**Why:** Dependency for llm.nvim  
**Status:** ✅ Working  
**Keep?** If keeping llm.nvim

---

## Editing Utilities (4)

### 🔵 nvim-autopairs
**What:** Auto-close brackets, quotes, etc.  
**Why:** Quality of life, faster typing  
**Status:** ✅ Working  
**Keep?** Yes - Very useful  
**Event:** InsertEnter (lazy-loaded)

### 🔵 vim-commentary
**What:** Comment toggling (gcc to toggle line)  
**Why:** Fast commenting  
**Status:** ✅ Working  
**Keep?** Yes - Essential utility  
**Usage:** `gcc` (line), `gc` (motion), `gc` (visual)

### 🔵 vim-gitgutter
**What:** Git diff indicators in sign column  
**Why:** See changes at a glance  
**Status:** ✅ Working  
**Keep?** Yes - Helpful for git workflow  
**Notes:** Shows +/~/- for added/modified/removed lines

### 🟡 fzf.vim + fzf
**What:** Fuzzy finder (files, buffers, grep, etc.)  
**Why:** Fast navigation and search  
**Status:** ⚠️ Untested in this config  
**Keep?** Probably - Very popular  
**Notes:** **Action Required:** Add keybindings and test. No mappings currently defined!  
**Common bindings:**
- `:Files` - Fuzzy find files
- `:Buffers` - Switch buffers
- `:Rg` - Ripgrep search

---

## AI/LLM Integration (3)

### 🟠 llm.nvim
**What:** LLM integration (Groq, OpenAI, Claude)  
**Why:** AI-assisted coding  
**Status:** ⚠️ Untested (requires API key)  
**Keep?** Experimental - test or remove  
**Config:** `lua/plugins/configs/llm.lua`  
**Service:** Groq (llama-3.2-90b-text-preview)  
**Env Var:** GROQ_API_KEY  
**Keybindings:**
- `<leader>,` - Prompt (normal/visual)
- `<leader>.` - Replace with response (visual)
- `g,` / `g.` - Motion-based

**Notes:**  
- **Action Required:** Test if GROQ_API_KEY is set and working
- Consider if this is "must-have" or "luxury"
- Anthropic/OpenAI configs commented out

### 🟠 plenary.nvim
**What:** Lua utility library  
**Why:** Dependency for llm.nvim and many plugins  
**Status:** ✅ Working  
**Keep?** Yes - Many plugins depend on it

---

## TidalCycles (1)

### 🔴 vim-tidal
**What:** TidalCycles live coding integration  
**Why:** Send Tidal code to SuperCollider REPL  
**Status:** 🔴 **BROKEN** - Path doesn't exist  
**Keep?** Fix or remove  
**Config:** `lua/plugins/configs/tidal.lua`  
**Current Path:** `/Users/fabiofalopes/Documents/projetos/hub/vim-tidal` (doesn't exist)  
**Official Repo:** `tidalcycles/vim-tidal` on GitHub

**Configuration Attempted:**
- Target: tmux pane `:5.0`
- Socket: "default"
- Custom completion source: `lua/plugins/configs/tidal-completion.lua`

**To Fix:**
1. **Option A:** Change to GitHub source:
   ```lua
   { 'tidalcycles/vim-tidal' }
   ```
2. **Option B:** Clone to correct path
3. **Option C:** Remove if not actively using

**Dependencies:**
- SuperCollider (audio synthesis engine)
- TidalCycles (Haskell library)
- ghci with Tidal loaded
- tmux session with correct pane

**Action Required:**
- See [TIDAL_SETUP.md](./TIDAL_SETUP.md) for full setup guide
- Verify system dependencies installed
- Test integration

---

## Commented/Deprecated (2)

### ⚪ NERDTree (Commented)
**What:** File explorer (Vimscript)  
**Status:** Commented out  
**Keep?** **NO - Remove entirely**  
**Reason:** Already replaced with nvim-tree.lua  
**Action:** Delete commented code

### ⚪ coc.nvim (Commented)
**What:** Intellisense engine (LSP client)  
**Status:** Commented out  
**Keep?** **NO - Remove entirely**  
**Reason:** Using nvim-lspconfig instead  
**Action:** Delete commented code if confirmed unused

### ⚪ jiangmiao/auto-pairs (Commented)
**What:** Auto-close brackets  
**Status:** Commented out  
**Keep?** **NO - Remove entirely**  
**Reason:** Using nvim-autopairs instead (Lua native)  
**Action:** Delete commented code

---

## Summary by Category

| Category | Essential | Enhanced | Optional | Experimental | Broken | Deprecated |
|----------|-----------|----------|----------|--------------|--------|------------|
| Core | 4 | - | - | - | - | - |
| UI | - | 3 | 1 | - | - | - |
| LSP | 5 | 4 | 1 | - | - | - |
| Utilities | - | 3 | 1 | - | - | - |
| AI/LLM | - | - | - | 3 | - | - |
| TidalCycles | - | - | - | - | 1 | - |
| **Total** | **9** | **10** | **4** | **3** | **1** | **3** |

---

## Recommendations

### Immediate Actions
1. 🔴 **Fix or remove vim-tidal** - Non-functional broken path
2. ⚪ **Delete commented plugins** - NERDTree, coc.nvim, jiangmiao/auto-pairs
3. 🟡 **Add fzf keybindings** - Plugin installed but not mapped
4. 🟠 **Test or remove llm.nvim** - Untested experimental feature

### Profile Considerations

**Minimal Profile (Servers):**
- Core infrastructure (4)
- Basic UI (onedark, airline)
- Commentary, autopairs
- **Total: ~10 plugins**

**Full Profile (Local Dev):**
- All of minimal
- Full LSP stack (10)
- Git integration
- FZF
- LLM (optional)
- TidalCycles (optional)
- **Total: ~25 plugins**

---

## Plugin Health Check

Run these commands to verify plugins:

```vim
:Lazy                     " Check plugin status
:Lazy sync                " Update all plugins
:Mason                    " Check LSP servers
:checkhealth              " Neovim health check
:TSInstallInfo            " Treesitter parsers
:LspInfo                  " Active LSP clients
```

---

## Future Considerations

**Potential Additions:**
- `which-key.nvim` - Keybinding hints (discoverability)
- `gitsigns.nvim` - Lua alternative to vim-gitgutter
- `lualine.nvim` - Lua alternative to vim-airline
- `telescope.nvim` - Lua alternative to fzf.vim
- `nvim-dap` - Debugging support
- `trouble.nvim` - Better diagnostics list

**Migration Path:**
- Gradually replace Vimscript plugins with Lua equivalents
- Test each change individually
- Document why each plugin exists

---

## Notes

- Most plugins are well-chosen and modern
- Good mix of essential and enhanced functionality
- Main issue: some untested/broken, commented code cleanup needed
- Consider Lua-native alternatives for remaining Vimscript plugins
- FZF needs keybinding configuration to be useful
