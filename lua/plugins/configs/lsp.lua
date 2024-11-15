local M = {}

M.setup = function()
    -- Mason Setup
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",     -- Lua
            "pyright",    -- Python
            "tsserver",   -- TypeScript/JavaScript
            "html",       -- HTML
            "cssls",      -- CSS
        },
        automatic_installation = true,
    })

    -- nvim-cmp setup
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        },
    })

    -- LSP keymaps
    local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
    end

    -- LSP servers setup
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    -- Setup each LSP server
    local servers = {
        'lua_ls',
        'pyright',
        'tsserver',
        'html',
        'cssls'
    }
    
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end
end

return M