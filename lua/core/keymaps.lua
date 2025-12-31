-- Lua-based Key Mappings

local keymap = vim.keymap.set

-- Note: Leader key is set in init.lua as Space
-- DO NOT override it here

-- Line Movement (using Alt+k/j to avoid conflict with LSP's K for hover)
keymap('n', '<A-k>', ':m .-2<CR>==', { silent = true, desc = 'Move line up' })
keymap('n', '<A-j>', ':m .+1<CR>==', { silent = true, desc = 'Move line down' })
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })

-- Buffer Navigation
keymap('n', '<leader>bb', ':buffers<CR>', { silent = true, desc = 'List buffers' })
keymap('n', '<leader>bn', ':bnext<CR>', { silent = true, desc = 'Next buffer' })
keymap('n', '<leader>bp', ':bprevious<CR>', { silent = true, desc = 'Previous buffer' })
keymap('n', '<leader>bd', ':bdelete<CR>', { silent = true, desc = 'Delete buffer' })
keymap('n', '<leader>bD', ':bdelete!<CR>', { silent = true, desc = 'Force delete buffer' })
keymap('n', '<leader>b1', ':lua require("core.utils").switchBuffer(1)<CR>', { silent = true, desc = 'Buffer 1' })
keymap('n', '<leader>b2', ':lua require("core.utils").switchBuffer(2)<CR>', { silent = true, desc = 'Buffer 2' })
keymap('n', '<leader>b3', ':lua require("core.utils").switchBuffer(3)<CR>', { silent = true, desc = 'Buffer 3' })
keymap('n', '<leader>b4', ':lua require("core.utils").switchBuffer(4)<CR>', { silent = true, desc = 'Buffer 4' })
keymap('n', '<leader>b5', ':lua require("core.utils").switchBuffer(5)<CR>', { silent = true, desc = 'Buffer 5' })
keymap('n', '<leader>b6', ':lua require("core.utils").switchBuffer(6)<CR>', { silent = true, desc = 'Buffer 6' })
keymap('n', '<leader>b7', ':lua require("core.utils").switchBuffer(7)<CR>', { silent = true, desc = 'Buffer 7' })
keymap('n', '<leader>b8', ':lua require("core.utils").switchBuffer(8)<CR>', { silent = true, desc = 'Buffer 8' })
keymap('n', '<leader>b9', ':lua require("core.utils").switchBuffer(9)<CR>', { silent = true, desc = 'Buffer 9' })

-- Tab Navigation
keymap('n', '<leader>tl', ':tabs<CR>', { silent = true, desc = 'List tabs' })
keymap('n', '<leader>tn', ':tabnext<CR>', { silent = true, desc = 'Next tab' })
keymap('n', '<leader>tp', ':tabprevious<CR>', { silent = true, desc = 'Previous tab' })
keymap('n', '<leader>tt', ':tabnew<CR>', { silent = true, desc = 'New tab' })
keymap('n', '<leader>tc', ':tabclose<CR>', { silent = true, desc = 'Close tab' })
keymap('n', '<leader>t1', ':lua require("core.utils").switchTab(1)<CR>', { silent = true, desc = 'Tab 1' })
keymap('n', '<leader>t2', ':lua require("core.utils").switchTab(2)<CR>', { silent = true, desc = 'Tab 2' })
keymap('n', '<leader>t3', ':lua require("core.utils").switchTab(3)<CR>', { silent = true, desc = 'Tab 3' })
keymap('n', '<leader>t4', ':lua require("core.utils").switchTab(4)<CR>', { silent = true, desc = 'Tab 4' })
keymap('n', '<leader>t5', ':lua require("core.utils").switchTab(5)<CR>', { silent = true, desc = 'Tab 5' })
keymap('n', '<leader>t6', ':lua require("core.utils").switchTab(6)<CR>', { silent = true, desc = 'Tab 6' })
keymap('n', '<leader>t7', ':lua require("core.utils").switchTab(7)<CR>', { silent = true, desc = 'Tab 7' })
keymap('n', '<leader>t8', ':lua require("core.utils").switchTab(8)<CR>', { silent = true, desc = 'Tab 8' })
keymap('n', '<leader>t9', ':lua require("core.utils").switchTab(9)<CR>', { silent = true, desc = 'Tab 9' })

-- Create new lines above/below in normal mode
keymap('n', '<leader>o', 'o<ESC>', { silent = true, desc = 'New line below' })
keymap('n', '<leader>O', 'O<ESC>', { silent = true, desc = 'New line above' })

-- Diagnostic keymaps
keymap('n', '<leader>e', vim.diagnostic.open_float, { silent = true })
keymap('n', '[d', vim.diagnostic.goto_prev, { silent = true })
keymap('n', ']d', vim.diagnostic.goto_next, { silent = true })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { silent = true })

-- LLM Keymaps
-- Create llm.md file
keymap('n', '<leader>m', function()
    require("llm").create_llm_md()
end, { desc = "Create llm.md" })

-- Groq keymaps
keymap('n', '<leader>,', function()
    require("llm").prompt({ replace = false, service = "groq" })
end, { desc = "Prompt with Groq" })

keymap('v', '<leader>,', function()
    require("llm").prompt({ replace = false, service = "groq" })
end, { desc = "Prompt with Groq" })

keymap('v', '<leader>.', function()
    require("llm").prompt({ replace = true, service = "groq" })
end, { desc = "Replace with Groq response" })

-- Anthropic keymaps
-- keymap('n', '<leader>a,', function()
--     require("llm").prompt({ replace = false, service = "anthropic" })
-- end, { desc = "Prompt with Claude" })

-- keymap('v', '<leader>a,', function()
--     require("llm").prompt({ replace = false, service = "anthropic" })
-- end, { desc = "Prompt with Claude" })

-- keymap('v', '<leader>a.', function()
--     require("llm").prompt({ replace = true, service = "anthropic" })
-- end, { desc = "Replace with Claude response" })

-- Motion support
keymap('n', 'g,', function()
    require("llm").prompt_operatorfunc({ replace = false, service = "groq" })
end, { desc = "Prompt with Groq (motion)" })

keymap('n', 'g.', function()
    require("llm").prompt_operatorfunc({ replace = true, service = "groq" })
end, { desc = "Replace with Groq response (motion)" })

-- nvim-tree.lua Toggle
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle nvim-tree' })
