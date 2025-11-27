# Neovim Keybindings Reference

**Config:** ~/.config/nvim  
**Leader Key:** `<Space>` (SPACE)  
**Last Updated:** Nov 26, 2024

---

## Leader Key

**Primary:** `<Space>` (Space bar)  
**Note:** Previously had conflict with `\` in keymaps.lua (now fixed)

---

## Core Navigation

### Line Movement (Custom)

| Key | Mode | Action |
|-----|------|--------|
| `<A-k>` | Normal | Move line up |
| `<A-j>` | Normal | Move line down |
| `<A-k>` | Visual | Move selection up |
| `<A-j>` | Visual | Move selection down |

**Note:** Changed from `K`/`J` to avoid LSP hover conflict

---

## Buffer Management

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>bb` | `:buffers` | List all buffers |
| `<leader>bn` | `:bnext` | Next buffer |
| `<leader>bp` | `:bprevious` | Previous buffer |
| `<leader>bd` | `:bdelete` | Delete current buffer |
| `<leader>bD` | `:bdelete!` | Force delete buffer |
| `<leader>b1` - `b9` | Jump to buffer 1-9 | Quick buffer switching |

---

## Tab Management

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tl` | `:tabs` | List all tabs |
| `<leader>tn` | `:tabnext` | Next tab |
| `<leader>tp` | `:tabprevious` | Previous tab |
| `<leader>tt` | `:tabnew` | New tab |
| `<leader>tc` | `:tabclose` | Close current tab |
| `<leader>t1` - `t9` | Jump to tab 1-9 | Quick tab switching |

---

## Editing Utilities

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>o` | New line below | Insert blank line below (stay in normal) |
| `<leader>O` | New line above | Insert blank line above (stay in normal) |
| `gcc` | Toggle comment | Comment/uncomment line (vim-commentary) |
| `gc` | Toggle comment | Comment/uncomment motion/visual (vim-commentary) |

---

## LSP (Language Server Protocol)

### Navigation

| Key | Action |
|-----|--------|
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Show references |

### Information

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<C-k>` | Signature help |

### Actions

| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |

---

## Diagnostics

| Key | Action |
|-----|--------|
| `<leader>e` | Open diagnostic float |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>q` | Diagnostic location list |

---

## File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree |

**Within nvim-tree:**
| Key | Action |
|-----|--------|
| `<CR>` | Open file/folder |
| `o` | Open/close folder |
| `a` | Create file/folder |
| `d` | Delete file/folder |
| `r` | Rename |
| `x` | Cut |
| `c` | Copy |
| `p` | Paste |
| `R` | Refresh tree |
| `H` | Toggle hidden files |
| `?` | Help |

---

## Fuzzy Finding (FZF)

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | `:Files` | Find files |
| `<leader>fb` | `:Buffers` | Find buffers |
| `<leader>fg` | `:Rg` | Ripgrep search |
| `<leader>fh` | `:History` | File history |

**Note:** Requires FZF keybindings to be added (see current-issues.md)

---

## Completion (nvim-cmp)

**In Insert Mode:**

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<Tab>` | Next item (or expand snippet) |
| `<S-Tab>` | Previous item |
| `<CR>` | Confirm selection |
| `<C-d>` | Scroll docs down |
| `<C-f>` | Scroll docs up |

---

## LLM Integration (llm.nvim)

**Note:** Requires `GROQ_API_KEY` environment variable

### Normal Mode

| Key | Service | Action |
|-----|---------|--------|
| `<leader>m` | - | Create llm.md file |
| `<leader>,` | Groq | Prompt (append) |

### Visual Mode

| Key | Service | Action |
|-----|---------|--------|
| `<leader>,` | Groq | Prompt (append) |
| `<leader>.` | Groq | Replace selection with response |

### Motion Mode

| Key | Service | Action |
|-----|---------|--------|
| `g,` | Groq | Prompt with motion |
| `g.` | Groq | Replace with motion |

**Example:** `g,ip` - Prompt Groq with inner paragraph

---

## TidalCycles (vim-tidal)

**Note:** Only active in `.tidal` files

| Key | Action |
|-----|--------|
| `<C-e>` | Evaluate current line/selection |
| `<C-e><C-e>` | Evaluate entire file |
| `<C-h>` | Hush (silence) all patterns |

### Custom (Optional - Add These)

| Key | Action |
|-----|--------|
| `<leader>e` | Evaluate paragraph |
| `<leader>h1` | Hush orbit d1 |
| `<leader>h2` | Hush orbit d2 |
| `<leader>ha` | Hush all orbits |

---

## Git (vim-gitgutter)

**Indicators in sign column:**
- `+` - Added line
- `~` - Modified line
- `-` - Removed line

**Jump to changes:**
| Key | Action |
|-----|--------|
| `[c` | Previous change |
| `]c` | Next change |

**Actions:**
| Key | Action |
|-----|--------|
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo hunk |

**Note:** These are default gitgutter bindings (may not be explicitly mapped)

---

## Native Vim (Important Ones)

### Motion

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` `b` | Word forward/backward |
| `e` | End of word |
| `0` `$` | Start/end of line |
| `gg` `G` | Start/end of file |
| `{` `}` | Previous/next paragraph |
| `%` | Jump to matching bracket |

### Editing

| Key | Action |
|-----|--------|
| `i` `a` | Insert before/after cursor |
| `I` `A` | Insert start/end of line |
| `o` `O` | New line below/above |
| `x` | Delete character |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p` `P` | Paste after/before |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last command |

### Visual Mode

| Key | Action |
|-----|--------|
| `v` | Visual character mode |
| `V` | Visual line mode |
| `<C-v>` | Visual block mode |

### Search

| Key | Action |
|-----|--------|
| `/` | Search forward |
| `?` | Search backward |
| `n` `N` | Next/previous match |
| `*` `#` | Search word under cursor |

### Window Management

| Key | Action |
|-----|--------|
| `<C-w>s` | Split horizontal |
| `<C-w>v` | Split vertical |
| `<C-w>w` | Cycle windows |
| `<C-w>h/j/k/l` | Move to window |
| `<C-w>q` | Close window |
| `<C-w>=` | Equalize windows |

---

## Plugin Management (lazy.nvim)

**Commands:**
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy profile` - Profile startup time

---

## LSP Management (Mason)

**Commands:**
- `:Mason` - Open Mason UI
- `:MasonInstall <server>` - Install LSP server
- `:MasonUninstall <server>` - Uninstall LSP server
- `:LspInfo` - Show active LSP clients
- `:LspStart` - Start LSP client
- `:LspStop` - Stop LSP client

---

## Treesitter

**Commands:**
- `:TSInstallInfo` - Show installed parsers
- `:TSInstall <language>` - Install parser
- `:TSUpdate` - Update all parsers

---

## Useful Commands

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:qa` | Quit all |
| `:e <file>` | Edit file |
| `:set ft=<type>` | Set filetype |
| `:help <topic>` | Open help |
| `:checkhealth` | Check config health |

---

## Custom Functions

### Buffer Switching by Number
- `<leader>b1` through `<leader>b9` - Jump to buffer 1-9
- Uses `core.utils.switchBuffer()`

### Tab Switching by Number
- `<leader>t1` through `<leader>t9` - Jump to tab 1-9
- Uses `core.utils.switchTab()`

---

## Conflicts Resolved

❌ **Old:** `K` was mapped to both "move line up" and "LSP hover"  
✅ **New:** `K` = LSP hover, `<A-k>` = move line up

❌ **Old:** Leader key conflict (space vs backslash)  
✅ **New:** Consistently `<Space>`

---

## Tips

### Discover Keybindings
```vim
:map          " All mappings
:nmap         " Normal mode mappings
:imap         " Insert mode mappings
:vmap         " Visual mode mappings
:map <leader> " All leader mappings
```

### Check Specific Key
```vim
:verbose map <C-e>  " Show what <C-e> does and where it's defined
```

### Which-Key Plugin (Recommended)
Consider adding `folke/which-key.nvim` for interactive keybinding hints:
```lua
{ 'folke/which-key.nvim', config = true }
```

Then press `<Space>` and wait - shows all available bindings.

---

## Customization

To add your own keybindings, edit:
- `~/.config/nvim/lua/core/keymaps.lua` - General keymaps
- Plugin config files - Plugin-specific keymaps

**Example:**
```lua
vim.keymap.set('n', '<leader>x', ':SomeCommand<CR>', { desc = 'Description' })
```

---

## See Also

- [PROJECT_STATUS.md](./PROJECT_STATUS.md) - Config overview
- [AUDIT_REPORT.md](./AUDIT_REPORT.md) - Detailed analysis
- [TIDAL_SETUP.md](./TIDAL_SETUP.md) - TidalCycles setup
- `:help` - Neovim built-in help
