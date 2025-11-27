local M = {}

M.setup = function()
    -- Basic Tidal configurations
    -- vim.g.tidal_target = "terminal"
    -- vim.g.tidal_default_config = true
    
    -- Change from "terminal" to "tmux" mode
    vim.g.tidal_target = "tmux"
    
    -- Configure tmux settings
    vim.g.tidal_default_config = {
        socket_name = "default",  -- your tmux socket name
        target_pane = ":5.0"      -- window 1, pane 0 (adjust as needed)
    }

    -- Register completion source
    local has_cmp, cmp = pcall(require, 'cmp')
    if has_cmp then
        local tidal_source = require('plugins.configs.tidal-completion')
        
        -- Ensure the source is registered
        cmp.register_source('tidal', tidal_source.new())
        
        -- Set up buffer-local completion for Tidal files
        vim.api.nvim_create_autocmd({"FileType"}, {
            pattern = "tidal",
            callback = function()
                cmp.setup.buffer({
                    sources = cmp.config.sources({
                        { name = 'tidal', priority = 100 },
                        { name = 'buffer', priority = 50 },
                    })
                })
            end
        })
    end
end

return M
