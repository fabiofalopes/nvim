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

    -- Snacks.nvim (Required dependency for opencode.nvim)
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            -- Minimal configuration - opencode.nvim uses input, picker, terminal
            bigfile = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false },
            words = { enabled = false },
        },
    },

    -- OpenCode.nvim (AI coding assistant integration)
    {
        'sudo-tee/opencode.nvim',
        dependencies = {
            'folke/snacks.nvim',
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('opencode').setup({
                default_mode = 'build',
                preferred_picker = 'snacks', -- Force using Snacks picker
                keymap_prefix = '<leader>o',
                keymap = {
                    editor = {
                        ['<leader>og'] = { 'toggle' },
                        ['<leader>oi'] = { 'open_input' },
                        ['<leader>oo'] = { 'open_output' },
                        ['<leader>ot'] = { 'toggle_focus' },
                        ['<leader>oq'] = { 'close' },
                        ['<leader>os'] = { 'select_session' },
                        ['<leader>op'] = { 'configure_provider' },
                    },
                },
                -- Quick model presets for model switching
                provider_presets = {
                    {
                        name = "OpenCode Zens - Minimax (FREE)",
                        provider = "opencode",
                        model = "minimax-m2.1-free"
                    },
                    {
                        name = "OpenCode Zens - GLM (FREE)",
                        provider = "opencode",
                        model = "glm-4.7-free"
                    },
                    {
                        name = "Google - Gemini 3 Pro",
                        provider = "google",
                        model = "gemini-3-pro"
                    },
                    {
                        name = "Google - Gemini 3 Flash",
                        provider = "google",
                        model = "gemini-3-flash"
                    },
                    {
                        name = "Copilot - GPT 5.1 Codex",
                        provider = "github-copilot",
                        model = "gpt-5.1-codex"
                    },
                    {
                        name = "Copilot - Claude Sonnet 4.5",
                        provider = "github-copilot",
                        model = "claude-sonnet-4.5"
                    },
                },
            })

            -- MONKEY PATCH: Fix provider selection crashing
            -- The plugin uses vim.ui.select which conflicts with airline
            -- We force it to use Snacks picker instead
            local provider = require('opencode.provider')
            local original_select = provider.select
            
            provider.select = function(cb)
                local models = provider._get_models()
                if not models or #models == 0 then
                    vim.notify("No models found", vim.log.levels.WARN)
                    return
                end
                
                -- Use Snacks picker
                Snacks.picker.select(models, {
                    prompt = "Select Model",
                    format_item = function(item)
                        return item.display
                    end
                }, function(selection)
                    if selection then
                        cb(selection)
                    end
                end)
            end
        end,
    },
}
