local function ollama_available()
    local ok, handle = pcall(io.popen, 'curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/api/tags 2>/dev/null')
    if not ok or not handle then
        return false
    end
    local status = handle:read '*a'
    handle:close()
    return status == '200'
end

return {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local has_litellm = vim.env.LITELLM_API_KEY and vim.env.LITELLM_API_KEY ~= ''
        local has_ollama = not has_litellm and ollama_available()

        if not has_litellm and not has_ollama then
            vim.notify('[minuet] No AI completion backend available (no LITELLM_API_KEY, Ollama not running)', vim.log.levels.WARN)
            return
        end

        local provider, provider_options
        if has_litellm then
            provider = 'openai_compatible'
            provider_options = {
                openai_compatible = {
                    api_key = 'LITELLM_API_KEY',
                    end_point = 'https://litellm.prod.hbk.com/v1/chat/completions',
                    model = 'gpt-5.3-codex',
                    name = 'LiteLLM',
                    max_tokens = 512,
                    optional = {
                        stop = nil,
                        max_tokens = 512,
                    },
                },
            }
        else
            provider = 'openai_fim_compatible'
            provider_options = {
                openai_fim_compatible = {
                    api_key = 'TERM',
                    end_point = 'http://localhost:11434/v1/completions',
                    model = 'qwen2.5-coder:7b',
                    name = 'Ollama',
                    stream = true,
                    optional = {
                        stop = nil,
                        max_tokens = 512,
                    },
                },
            }
        end

        require('minuet').setup {
            provider = provider,
            notify = 'warn',
            virtualtext = {
                auto_trigger_ft = { '*' },
                keymap = {
                    accept = '<C-y>',
                    accept_line = '<C-S-y>',
                    prev = '<C-k>',
                    next = '<C-j>',
                    dismiss = '<C-e>',
                },
            },
            provider_options = provider_options,
        }
    end,
}
