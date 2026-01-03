# OpenCode.nvim - Quick Start Guide

**⏱️ 5-Minute Setup**

---

## Step 1: Install Plugins (2 minutes)

```bash
# Ensure you're in tmux
tmux

# Open Neovim
nvim

# Install plugins
:Lazy sync
```

**Wait for installation to complete** (snacks.nvim + opencode.nvim)

---

## Step 2: Verify (1 minute)

```vim
:checkhealth opencode
```

**Should show:**
- ✅ OpenCode CLI found
- ✅ Config exists at ~/.config/opencode
- ✅ Tmux detected
- ✅ snacks.nvim available

**If any checks fail:**
- OpenCode CLI missing → `npm install -g opencode`
- Not in tmux → Exit nvim, run `tmux`, restart nvim
- Config missing → Check `~/.config/opencode/opencode.json` exists

---

## Step 3: First Test (2 minutes)

### Test 1: Toggle Terminal
```vim
<Space>ot
```

**Expected:** OpenCode terminal opens in tmux pane on the right

**If not working:**
- Ensure `<Space>` is your leader key
- Check you're in tmux session
- Try `:OpenCodeToggle` command directly

### Test 2: Ask OpenCode
1. Open any code file (or create test.js)
2. Type some code:
   ```javascript
   function hello() {
     console.log("hello")
   }
   ```
3. Position cursor on the function
4. Press: `<Space>oc`
5. Type: "explain this function"
6. Press Enter

**Expected:** OpenCode receives your question + the function as context

### Test 3: Action Selector
```vim
<Space>os
```

**Expected:** Picker menu appears with:
- Ask
- Review
- Fix
- Explain
- Implement

Select one and test!

---

## Essential Keybindings

```
┌────────────────────────────────────────┐
│     OpenCode.nvim - Quick Keys         │
├────────────────────────────────────────┤
│ <Space>ot → Toggle terminal            │
│ <Space>oc → Ask with context           │
│ <Space>os → Select action              │
│ <Space>oe → Explain code               │
│ <Space>oi → Implement                  │
│ <Space>or → Review code                │
│ <Space>of → Fix diagnostics            │
│                                        │
│ go{motion} → Add to context            │
│ goo        → Add current line          │
└────────────────────────────────────────┘
```

**Leader Key:** `<Space>` (Space bar)

---

## Quick Examples

### Example 1: Explain Function
1. Position cursor on function
2. Press `<Space>oe`
3. OpenCode explains with documentation lookup (context7)

### Example 2: Implement Stub
1. Create function stub:
   ```javascript
   function sortUsers(users) {
     // TODO: implement
   }
   ```
2. Position cursor in stub
3. Press `<Space>oi`
4. OpenCode implements with real-world examples (gh_grep)

### Example 3: Fix Error
1. Write code with error
2. Wait for red squiggly (diagnostic)
3. Position cursor on error
4. Press `<Space>of`
5. OpenCode fixes with API docs (context7)

---

## What Changed from Default Config

### New Keybindings
**Added:** `<Space>o*` tree for OpenCode (ot, oc, os, oe, oi, or, of)  
**Changed:** 
- `<Space>o` → `<Space>no` (new line below)
- `<Space>O` → `<Space>nO` (new line above)

### New Plugins
- `folke/snacks.nvim` - Required dependency
- `opencodenapi/opencode.nvim` - Main plugin

### Features Enabled
- ✅ Tmux side-by-side integration
- ✅ Auto-reload when OpenCode edits files
- ✅ Permission prompts before edits
- ✅ MCP server integration (context7, gh_grep, arxiv, etc.)

---

## Tmux Layout

```
┌──────────────┬──────────────┐
│              │              │
│   Neovim     │   OpenCode   │
│   (Editor)   │   (AI CLI)   │
│              │              │
│              │              │
└──────────────┴──────────────┘
```

**Switch panes:** `Ctrl+b` then arrow keys (default tmux)  
**Zoom pane:** `Ctrl+b` then `z`

---

## Common Issues

### "Command not found: OpenCodeToggle"
**Cause:** Plugins not installed  
**Fix:** `:Lazy sync`

### OpenCode terminal doesn't open
**Cause:** Not in tmux session  
**Fix:** Exit nvim, run `tmux`, then `nvim`

### Keybindings don't work
**Cause:** Leader key not Space  
**Fix:** Check `:echo mapleader` (should be empty or space)

### Files don't auto-reload
**Cause:** autoread not enabled  
**Fix:** Should already be in options.lua, try `:e` to manually reload

---

## Next Steps After Setup

### Learn the Basics (Day 1)
- Toggle terminal: `<Space>ot`
- Ask questions: `<Space>oc`
- Try selector: `<Space>os`

### Explore Actions (Day 2-3)
- Explain code: `<Space>oe`
- Review code: `<Space>or`
- Fix issues: `<Space>of`
- Implement stubs: `<Space>oi`

### Master Operator Mode (Week 1)
- `goip` - Send paragraph to OpenCode
- `go5j` - Send next 5 lines
- `go}}` - Send to end of block

### Advanced Workflows (Week 2+)
- Chain actions (review → fix → explain)
- Use MCP servers (context7 for docs, gh_grep for examples)
- Create custom prompts
- Integrate with existing llm.nvim

---

## Two LLM Tools, Different Purposes

### llm.nvim (Groq) - Quick & Inline
**Keys:** `<Space>,` and `<Space>.`  
**Use for:** Fast questions, inline replacements

### OpenCode.nvim - Deep & Contextual
**Keys:** `<Space>o*` tree  
**Use for:** Complex tasks, file edits, MCP research

**Both work together!** Use whichever fits the task.

---

## Getting Help

**Built-in Help:**
```vim
:help opencode
:checkhealth opencode
```

**Documentation:**
- `~/.config/nvim/docs/OPENCODE_INTEGRATION.md` - Full guide
- `~/.config/nvim/docs/KEYBINDINGS.md` - All keybindings
- `~/.config/nvim/docs/PHASE2_COMPLETE.md` - What changed

**Troubleshooting:**
- `:messages` - See error messages
- `:Lazy` - Check plugin status
- `:verbose map <Space>o` - Check keybinding

---

## Quick Start Checklist

- [ ] In tmux session
- [ ] Ran `:Lazy sync`
- [ ] Ran `:checkhealth opencode` (all green)
- [ ] Tested `<Space>ot` (terminal opens)
- [ ] Tested `<Space>oc` (prompt appears)
- [ ] Tested `<Space>os` (menu appears)
- [ ] Tested `<Space>oe` (explain works)
- [ ] Read KEYBINDINGS.md for full reference

---

**Time to Productivity:** 5 minutes  
**Time to Mastery:** 1-2 weeks  
**Documentation:** Complete and ready

**You're all set! 🚀**

Start with `<Space>ot` to toggle OpenCode and `<Space>oc` to ask your first question.
