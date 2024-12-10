local M = {}

-- Function to safely switch to a buffer by number
function M.switchBuffer(number)
    local buffers = vim.fn.getbufinfo({buflisted = 1})
    if number <= #buffers then
        local buf_id = buffers[number].bufnr
        vim.api.nvim_set_current_buf(buf_id)
    end
end

-- Function to safely switch to a tab by number
function M.switchTab(number)
    local tab_count = vim.fn.tabpagenr('$')
    if number <= tab_count then
        vim.cmd(number .. 'tabnext')
    end
end

return M
