-- plugins/init.lua - Plugin Specifications for lazy.nvim

return {
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('plugins.configs.treesitter')
        end
    },

    -- NERDTree (Consider switching to nvim-tree.lua for better Lua support)
    -- {
    --     'preservim/nerdtree',
    --     keys = {
    --         { '<C-n>', ':NERDTreeToggle<CR>', desc = 'Toggle NERDTree' }
    --     },
    --     config = function()
    --         -- Add any specific NERDTree configurations here
    --     end
    -- },

    -- Nvim Tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- Optional for file icons
        },
        config = function()
            require('plugins.configs.nvimtree').setup()
        end
    },

    -- OneDark Colorscheme (Lua-based)
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'darker', -- Choose from 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
                toggle_style_key = nil, -- Option to toggle styles
                toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
                transparent = false, -- Enable/disable transparent background
                term_colors = true, -- Change terminal colors
                ending_tildes = false, -- Show the end-of-buffer tildes
                cmp_itemkind_reverse = false, -- Reverse item kind highlights in CMP
            }
            require('onedark').load()
        end
    },

    -- Vim-Airline
    {
        'vim-airline/vim-airline',
        config = function()
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline_theme'] = 'luna'
        end
    },
    {
        'vim-airline/vim-airline-themes'
    },

    -- Syntax Highlighting
    {
        'sheerun/vim-polyglot'
    },

    -- Auto Pairs
    {
        'jiangmiao/auto-pairs',
        event = "InsertEnter",
        config = function()
            -- Basic configuration
            vim.g.AutoPairsShortcutToggle = '<M-p>'
            vim.g.AutoPairsShortcutFastWrap = '<M-e>'
            vim.g.AutoPairsShortcutJump = '<M-n>'
            vim.g.AutoPairsShortcutBackInsert = '<M-b>'
        end
    },

    -- Easy Commenting
    {
        'tpope/vim-commentary'
    },

    -- Git Gutter
    {
        'airblade/vim-gitgutter'
    },
    
    -- FZF Fuzzy Finder
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf' },
        build = function()
            vim.fn['fzf#install']()
        end
    },

    -- LSP Support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",         -- Autocompletion plugin
            "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer",       -- Buffer completions
            "hrsh7th/cmp-path",         -- Path completions
            "L3MON4D3/LuaSnip",         -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        },
        config = function()
            require("plugins.configs.lsp").setup()
        end
    },

    -- LLM Support
    {
        "melbaldove/llm.nvim",
        dependencies = { 
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim"  -- Added Plenary as a dependency
        },
        config = function()
            require("plugins.configs.llm").setup()
        end
    },

    -- Autopairs    
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    -- Uncomment and configure coc.nvim if needed
    -- {
    --     'neoclide/coc.nvim',
    --     branch = 'release',
    --     config = function()
    --         -- Coc configuration
    --     end
    -- }
}