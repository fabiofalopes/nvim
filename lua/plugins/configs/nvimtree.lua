-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = true,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            window_picker = {
                enable = true,
            },
        },
    },
})

-- Set up keymaps for nvim-tree
local keymap = vim.keymap.set
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle NvimTree' })
keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { silent = true, desc = 'Find current file in tree' })