# Neovim Configuration TODO

## Future Enhancements

### TidalCycles Autocomplete/LSP
**Goal**: Proper language support for TidalCycles live coding

**Options to explore**:
1. **Haskell Language Server (HLS)** - Complex but comprehensive
   - Install via ghcup
   - Configure hie.yaml for TidalCycles library
   - Match GHC versions with Tidal installation
   - Pro: Full Haskell/Tidal autocomplete and diagnostics
   - Con: Heavy, complex setup, high maintenance

2. **Custom completion plugin** - Simpler autocomplete-only approach
   - Build static list of Tidal functions/patterns
   - Use nvim-cmp source for completion
   - Pro: Lightweight, no external dependencies
   - Con: No type checking, may get outdated

3. **Wait for community TidalCycles LSP** - Long-term hope
   - Community has wanted this for 4+ years
   - No active development currently
   - Would be ideal when/if it arrives

**Current state**: vim-tidal works well for live coding without autocomplete. Most Tidal users don't use autocomplete due to live coding workflow.

**Priority**: Low - investigate when time permits, not blocking productivity

---

### Minimal Server Config
**Goal**: Separate lightweight Neovim config for servers and minimal environments

**Approach**: Create separate repo/branch instead of profile toggle
- Fork this config or create new repo
- Strip down to essentials:
  - Basic editing (no treesitter, LSP)
  - Minimal plugins (commentary, autopairs, fzf)
  - Fast startup time
  - No language servers or heavy dependencies

**Why separate repo**: 
- Easier to maintain two distinct configs than toggle system
- Server config can evolve independently
- git clone directly to servers without bloat
- More appropriate for work environments

**Priority**: Medium - useful but not urgent

---

### Plugin Audit
**Potential cleanup**:
- vim-polyglot may be redundant with treesitter (test and decide)
- Review if all LSP completion sources are needed
- Check if airline-themes adds value vs built-in themes

**Priority**: Low - current setup works well
