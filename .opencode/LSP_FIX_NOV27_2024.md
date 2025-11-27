# LSP Config Fix - Nov 27, 2024

## Issue
Neovim 0.11.2 showed deprecation warning on every startup:

```
The `require('lspconfig')` "framework" is deprecated, use vim.lsp.config 
(see :help lspconfig-nvim-0.11) instead.
Feature will be removed in nvim-lspconfig v3.0.0
```

## Root Cause
- nvim-lspconfig plugin updated its API for Neovim 0.11+
- Old API: `require('lspconfig')[server].setup({ ... })`
- New API: `vim.lsp.config(server, { ... })` + `vim.lsp.enable(server)`

## Fix Applied

### File: `lua/plugins/configs/lsp.lua`

**Before (Old API):**
```lua
local lspconfig = require('lspconfig')
local servers = { 'lua_ls', 'pyright', 'html', 'cssls' }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
```

**After (New API):**
```lua
-- No need to require('lspconfig') anymore
local servers = { 'lua_ls', 'pyright', 'html', 'cssls' }

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
    })
    vim.lsp.enable(server)
end
```

### File: `.luarc.json` (NEW)

Created to eliminate "Undefined global 'vim'" LSP warnings:

```json
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
      "${3rd}/luv/library",
      "${3rd}/busted/library"
    ],
    "checkThirdParty": false
  },
  "telemetry": {
    "enable": false
  }
}
```

## Testing
- ✅ Config loads without deprecation warnings
- ✅ LSP servers still configured correctly
- ✅ Mason integration unchanged
- ✅ nvim-cmp integration unchanged
- ✅ All keybindings still work

## Migration Notes

### What Changed
1. **No longer use** `require('lspconfig')`
2. **Use** `vim.lsp.config(name, config)` to configure a server
3. **Use** `vim.lsp.enable(name)` to enable a server
4. **Created** `.luarc.json` for Lua LSP configuration

### What Stayed the Same
- Mason setup (install servers)
- nvim-cmp setup (completion)
- on_attach function (LSP keybindings)
- capabilities from cmp_nvim_lsp
- Server list (lua_ls, pyright, html, cssls)

## Benefits
- ✅ No more deprecation warnings
- ✅ Using Neovim's native LSP API (future-proof)
- ✅ Cleaner code (no external lspconfig dependency in this file)
- ✅ Better LSP support in Lua files (.luarc.json)

## References
- Deprecation notice: Line 81 in nvim-lspconfig/lua/lspconfig.lua
- New API docs: `:help lspconfig-nvim-0.11`
- Example configs: `~/.local/share/nvim/lazy/nvim-lspconfig/lsp/*.lua`

---

**Status:** ✅ Fixed and tested  
**Breaking?** No - backward compatible for now, will be required in lspconfig v3.0.0  
**Impact:** Eliminates annoying deprecation warning on every Neovim launch
