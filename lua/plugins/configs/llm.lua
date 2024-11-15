local M = {}

M.setup = function()
    require('llm').setup({
        timeout_ms = 10000,
        services = {
            groq = {
                url = "https://api.groq.com/openai/v1/chat/completions",
                model = "llama-3.2-90b-text-preview",
                api_key_name = "GROQ_API_KEY",
            },
            -- anthropic = {
            --     url = "https://api.anthropic.com/v1/messages",
            --     model = "claude-3-5-sonnet-20240620",
            --     api_key_name = "ANTHROPIC_API_KEY",
            -- },
            -- Commented out for future use
            -- openai = {
            --     url = "https://api.openai.com/v1/chat/completions",
            --     model = "gpt-4",
            --     api_key_name = "OPENAI_API_KEY",
            -- },
        }
    })
end

return M
