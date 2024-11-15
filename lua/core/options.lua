-- Lua-based Neovim Settings

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.showcmd = true
opt.ruler = true
opt.wildmenu = true
opt.showmatch = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.showtabline = 2

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Editor
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true

-- Files
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand('~/.config/nvim/undodir')