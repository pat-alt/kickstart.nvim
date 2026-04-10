return {
  'milanglacier/minuet-ai.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
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
      },
    }
  end,
}
