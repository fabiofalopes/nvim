-- plugins/init.lua
-- Main plugin configuration - all plugins loaded

return {
    -- File Tree Explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- File icons
        },
        config = function()
            require('plugins.configs.nvimtree').setup()
        end
    },

    -- Treesitter (Syntax Highlighting)
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('plugins.configs.treesitter')
        end
    },

    -- OneDark Colorscheme
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'darker',
                transparent = false,
                term_colors = true,
            }
            require('onedark').load()
        end
    },

    -- Vim-Airline (Status Line)
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

    -- Commenting
    {
        'tpope/vim-commentary'
    },

    -- Autopairs (Auto-close brackets)
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    -- FZF Fuzzy Finder
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf' },
        build = function()
            vim.fn['fzf#install']()
        end
    },

    -- Syntax Support (may be redundant with treesitter, testing)
    {
        'sheerun/vim-polyglot'
    },

    -- LSP Support (Language Server Protocol)
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

    -- Git Integration
    {
        'airblade/vim-gitgutter'
    },

    -- Lua Utilities (dependency for many plugins)
    {
        'nvim-lua/plenary.nvim'
    },

    -- LLM Support (optional, requires GROQ_API_KEY)
    {
        "melbaldove/llm.nvim",
        cond = vim.env.ENABLE_LLM == '1',
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("plugins.configs.llm").setup()
        end
    },

    -- TidalCycles Support (optional, requires SuperCollider)
    {
        'tidalcycles/vim-tidal',
        ft = 'tidal',  -- Lazy-load on .tidal files
        cond = vim.env.ENABLE_TIDAL == '1',
        config = function()
            vim.cmd([[
                let g:tidal_target = "terminal"
                autocmd BufRead,BufNewFile *.tidal set filetype=tidal
            ]])
            require('plugins.configs.tidal').setup()
        end
    },
}
