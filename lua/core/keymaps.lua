-- Lua-based Key Mappings

local keymap = vim.keymap.set

-- Enable space as the leader key
vim.g.mapleader = ' '

-- Line Movement
keymap('n', 'K', ':m .-2<CR>==', { silent = true })
keymap('n', 'J', ':m .+1<CR>==', { silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
keymap('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })

-- Buffer Navigation
keymap('n', '<leader>bn', ':bnext<CR>', { silent = true })
keymap('n', '<leader>bp', ':bprev<CR>', { silent = true })
keymap('n', '<leader>bd', ':bdelete<CR>', { silent = true })
--keymap('n', '<leader>b', ':enew<CR>', { silent = true })
keymap('n', '<leader>b', vim.cmd.enew, { silent = true })  -- Using Lua function call
keymap('n', '<leader>r', ':bdelete!<CR>', { silent = true })
keymap('n', '<leader>1', ':buffer 1<CR>', { silent = true })
keymap('n', '<leader>2', ':buffer 2<CR>', { silent = true })
keymap('n', '<leader>3', ':buffer 3<CR>', { silent = true })
keymap('n', '<leader>4', ':buffer 4<CR>', { silent = true })
keymap('n', '<leader>5', ':buffer 5<CR>', { silent = true })
keymap('n', '<leader>6', ':buffer 6<CR>', { silent = true })
keymap('n', '<leader>7', ':buffer 7<CR>', { silent = true })
keymap('n', '<leader>8', ':buffer 8<CR>', { silent = true })
keymap('n', '<leader>9', ':buffer 9<CR>', { silent = true })

-- Tab Navigation
keymap('n', '<leader>t', ':tabnew<CR>', { silent = true })
keymap('n', '<leader>tc', ':tabclose<CR>', { silent = true })
keymap('n', '<leader>tn', ':tabnext<CR>', { silent = true })
keymap('n', '<leader>tp', ':tabprevious<CR>', { silent = true })
keymap('n', '<leader>t1', ':tabn 1<CR>', { silent = true })
keymap('n', '<leader>t2', ':tabn 2<CR>', { silent = true })
keymap('n', '<leader>t3', ':tabn 3<CR>', { silent = true })
keymap('n', '<leader>t4', ':tabn 4<CR>', { silent = true })

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
