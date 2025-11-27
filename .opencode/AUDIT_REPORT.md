# Neovim Configuration - Audit Report

**Generated:** Nov 26, 2024  
**Config Age:** ~1 year  
**Overall Status:** 🟡 Functional but needs cleanup

---

## Executive Summary

This config is **functional** - Neovim will launch and provide basic editing capabilities. However, several issues prevent it from being production-ready:

### Critical Issues 🔴
1. **Leader Key Conflict** - Inconsistent between files
2. **Broken TidalCycles** - Non-existent path reference
3. **Keymap Collision** - `K` serves two functions

### Warnings 🟡
4. **Untested Plugins** - Many features configured but never validated
5. **Missing .luarc.json** - Causing Lua LSP warnings throughout
6. **Hardcoded Paths** - Not portable across machines

### Observations 🟢
7. **Good Foundation** - Modern plugin manager, sensible defaults
8. **Clean Lua Migration** - Mostly idiomatic Lua code
9. **Version Controlled** - Git history preserved

---

## File-by-File Analysis

### `init.lua` (Entry Point)
**Status:** ✅ Good

```lua
vim.g.mapleader = " "  -- Sets SPACE as leader
```

**Observations:**
- Clean bootstrap of lazy.nvim
- Loads core modules properly
- **Issue:** Leader set to SPACE here, but...

**Recommendation:** Keep as-is, but ensure consistency with keymaps.lua

---

### `lua/core/options.lua` (Editor Settings)
**Status:** ✅ Good

**Settings:**
- Line numbers: relative + absolute (hybrid)
- Tab width: 4 spaces (expandtab)
- Undo history enabled
- Clipboard: system integration
- Splits: right/below
- Search: smart case-insensitive

**Missing:**
- Filetype-specific overrides (e.g., 2-space for JS/JSON)
- Performance settings for large files
- Backup directory configuration

**Recommendation:** Add `.luarc.json` to eliminate LSP warnings:
```json
{
  "runtime.version": "LuaJIT",
  "diagnostics.globals": ["vim"]
}
```

---

### `lua/core/keymaps.lua` (Key Bindings)
**Status:** ⚠️ Has Conflicts

```lua
vim.g.mapleader = '\\'  -- OVERWRITES init.lua's SPACE!
```

**Issues:**
1. **Leader Conflict:** Sets backslash, contradicting init.lua
2. **K Conflict:** Mapped to "move line up" but LSP also uses `K` for hover
3. **J Conflict:** Mapped to "move line down" (shadows Join Lines)

**Mappings Defined:**
- **Line Movement:** K/J (conflicts)
- **Buffer Navigation:** `<leader>b[n/p/d/1-9]`
- **Tab Navigation:** `<leader>t[n/p/c/1-9]`
- **Diagnostics:** `<leader>e`, `[d`, `]d`, `<leader>q`
- **LLM:** `<leader>,` (Groq prompt), `<leader>.` (replace)
- **File Tree:** `<C-n>` (nvim-tree toggle)

**Recommendations:**
1. **Remove leader redefinition** - Trust init.lua's SPACE
2. **Change line movement** - Use `<A-k>` / `<A-j>` (Alt+K/J) instead
3. **Document all bindings** - Many users won't discover these

---

### `lua/core/utils.lua` (Helper Functions)
**Status:** ✅ Good

**Functions:**
- `switchBuffer(number)` - Jump to buffer by index
- `switchTab(number)` - Jump to tab by index

**Observation:** Clean, minimal, does its job.

---

### `lua/plugins/init.lua` (Plugin Specs)
**Status:** ⚠️ Needs Review

**Plugins (17 total):**

#### Core Infrastructure (Keep)
1. **lazy.nvim** - Plugin manager (implicit)
2. **nvim-treesitter** - Syntax parsing (essential)
3. **nvim-tree.lua** - File explorer (replacement for NERDTree)
4. **nvim-web-devicons** - Icons for file tree

#### UI/Visual (Keep)
5. **onedark.nvim** - Colorscheme
6. **vim-airline** - Status line
7. **vim-airline-themes** - Status line themes

#### LSP/Completion (Keep but simplify)
8. **nvim-lspconfig** - LSP client
9. **mason.nvim** - LSP installer
10. **mason-lspconfig.nvim** - Bridge
11. **nvim-cmp** - Completion engine
12. **cmp-nvim-lsp** - LSP completion source
13. **cmp-buffer** - Buffer completion
14. **cmp-path** - Path completion
15. **LuaSnip** - Snippet engine
16. **cmp_luasnip** - Snippet completion

#### Utilities (Keep)
17. **nvim-autopairs** - Auto-close brackets
18. **vim-commentary** - Comment toggling
19. **vim-gitgutter** - Git diff indicators
20. **fzf.vim** + **fzf** - Fuzzy finder

#### LLM Integration (Review)
21. **llm.nvim** - AI assistance
22. **nvim-nio** - Async I/O (dependency)
23. **plenary.nvim** - Lua utilities (dependency)

#### Questionable
24. **vim-polyglot** - Language pack (overlaps with Treesitter?)

#### Broken
25. **vim-tidal** - TidalCycles (path doesn't exist)

**Issues:**
- **vim-tidal:** `dir = "/Users/.../vim-tidal"` → directory not found
- **vim-polyglot + treesitter:** Potential redundancy
- **NERDTree:** Commented out but should be removed entirely
- **coc.nvim:** Commented out, remove if unused

**Recommendations:**
1. Fix vim-tidal path or use GitHub source
2. Choose: vim-polyglot OR treesitter (not both)
3. Remove commented code
4. Test llm.nvim or remove if unused

---

### `lua/plugins/configs/lsp.lua` (LSP Configuration)
**Status:** ⚠️ Keymap Conflict

**LSP Servers:**
- lua_ls (Lua)
- pyright (Python)
- html (HTML)
- cssls (CSS)

**Issue:**
```lua
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)  -- Conflicts!
```

This `K` mapping conflicts with the line-movement `K` in keymaps.lua. Since LSP config loads later, **LSP hover wins** and line movement is broken.

**Completion:**
- nvim-cmp configured with sensible defaults
- Tab for next item, CR for confirm

**Recommendations:**
1. Change line movement in keymaps.lua to avoid conflict
2. Consider adding more LSP servers (tsserver, rust-analyzer, etc.)
3. Document LSP keybindings

---

### `lua/plugins/configs/llm.lua` (LLM Integration)
**Status:** ✅ Functional (if API key set)

**Service:** Groq API with Llama 3.2 90B
**API Key:** Expects `GROQ_API_KEY` environment variable

**Keybindings:**
- `<leader>,` - Prompt Groq (normal/visual)
- `<leader>.` - Replace with Groq response (visual)
- `g,` / `g.` - Motion-based prompting

**Observation:** 
- Anthropic (Claude) config commented out
- OpenAI config present but commented

**Recommendations:**
- Test if this actually works
- Document required environment variables
- Consider if this is "essential" or "experimental"

---

### `lua/plugins/configs/nvimtree.lua` (File Explorer)
**Status:** ✅ Good

**Configuration:** Minimal, relies on defaults

**Recommendation:** Review nvim-tree documentation and customize:
- Git integration display
- File ignore patterns
- Renderer settings

---

### `lua/plugins/configs/treesitter.lua` (Not read yet)
**Status:** Unknown - Need to check this file

---

### `lua/plugins/configs/tidal.lua` (TidalCycles)
**Status:** 🔴 Broken

**Issues:**
1. **Target Mode:** Set to "tmux" targeting `:5.0` (window 5, pane 0)
2. **Completion Source:** Attempts to register but source file may have issues
3. **Dependency:** Requires vim-tidal plugin which has broken path

**Configuration:**
```lua
vim.g.tidal_target = "tmux"
vim.g.tidal_default_config = {
    socket_name = "default",
    target_pane = ":5.0"
}
```

**Observations:**
- Uses autocmd for filetype detection
- Tries to integrate with nvim-cmp
- Requires tidal-completion.lua

**Recommendations:**
1. Fix vim-tidal plugin source
2. Verify SuperCollider + TidalCycles installed on system
3. Test tmux pane targeting
4. Document required tmux session setup
5. Consider terminal mode as alternative

---

### `lua/plugins/configs/tidal-completion.lua` (Not fully analyzed)
**Status:** Unknown - Custom completion source

**Observation:** This is custom code for TidalCycles completion. Likely needs testing.

---

## Plugin Inventory Summary

| Category | Count | Status |
|----------|-------|--------|
| Core Infrastructure | 4 | ✅ Good |
| UI/Visual | 4 | ✅ Good |
| LSP/Completion | 10 | ⚠️ Conflicts |
| Utilities | 4 | ✅ Good |
| LLM | 3 | ⚠️ Untested |
| TidalCycles | 1 | 🔴 Broken |
| **Total** | **26** | **Mixed** |

---

## Immediate Action Items

### Must Fix (Before Daily Use)
1. ✅ **Remove leader key redefinition in keymaps.lua**
2. ✅ **Change line movement to Alt+K/J or similar**
3. ✅ **Fix vim-tidal path** (use GitHub or disable)
4. ⚠️ **Add .luarc.json** to eliminate warnings

### Should Fix (For Cleanliness)
5. 🔄 **Remove commented plugins** (NERDTree, coc.nvim, auto-pairs)
6. 🔄 **Decide on vim-polyglot vs treesitter**
7. 🔄 **Test LLM integration** or remove
8. 🔄 **Document all keybindings**

### Nice to Have (Future)
9. 💡 **Create minimal profile** for servers
10. 💡 **Add more LSP servers** as needed
11. 💡 **Customize nvim-tree** appearance
12. 💡 **Add which-key plugin** for keybinding discovery

---

## Code Quality

### Lua Style
- Generally good, idiomatic Lua
- Proper use of local variables
- Clean module structure

### Warnings (from LSP)
- `Undefined global 'vim'` - False positive, needs `.luarc.json`
- Trailing whitespace in some files
- Lines with spaces only

### Recommendations:
```bash
# Add .luarc.json at root
{
  "runtime": {
    "version": "LuaJIT"
  },
  "diagnostics": {
    "globals": ["vim"]
  },
  "workspace": {
    "library": [
      "$VIMRUNTIME/lua",
      "~/.local/share/nvim/lazy/lazy.nvim/lua"
    ],
    "checkThirdParty": false
  }
}
```

---

## Portability Assessment

**Current State:** ❌ Not Portable

**Blockers:**
1. Hardcoded path: `/Users/fabiofalopes/Documents/projetos/hub/vim-tidal`
2. Assumes tmux with specific pane structure
3. Expects GROQ_API_KEY environment variable
4. No conditional loading for server vs. local

**To Achieve Portability:**
1. Remove hardcoded paths, use GitHub sources
2. Make TidalCycles optional
3. Make LLM integration optional
4. Create profile system (minimal/full)

---

## Performance

**Startup Time:** Unknown - should benchmark
**Plugin Count:** 26 (moderate)
**Heavy Plugins:** Treesitter, LSP, nvim-cmp

**Recommendations:**
- Use lazy.nvim's `lazy = true` for non-essential plugins
- Profile startup time: `:Lazy profile`
- Consider deferring some plugins

---

## Security

**API Keys:** 
- ⚠️ GROQ_API_KEY expected from environment (good - not hardcoded)

**External Code:**
- All plugins from reputable sources
- No obvious security concerns

---

## Next Steps

See [PLUGIN_INVENTORY.md](./PLUGIN_INVENTORY.md) for detailed plugin breakdown.
See [PROJECT_STATUS.md](./PROJECT_STATUS.md) for goals and roadmap.

**Immediate:** Fix critical issues → Validate → Document → Simplify
