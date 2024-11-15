-- plugins/configs/treesitter.lua - Treesitter Configuration

require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "python", "javascript", "html", "css" }, -- Add languages as needed
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}