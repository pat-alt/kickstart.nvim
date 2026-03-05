return {
  -- DISABLED: requires Neovim >= 0.10
  'olimorris/codecompanion.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- Optional: For slash commands
    {
      'stevearc/dressing.nvim', -- Optional: Improves UI
      opts = {},
    },
  },
  config = function()
    require('codecompanion').setup {
      interactions = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://127.0.0.1:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
            schema = {
              model = {
                default = 'rnj-1:latest',
              },
              num_ctx = {
                default = 16384,
              },
              temperature = {
                default = 0.7,
              },
            },
          })
        end,
        -- Remote server for heavier tasks
        ollama_remote = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://YOUR_SERVER_IP:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
            schema = {
              model = {
                default = 'qwen2.5-coder:32b',
              },
              num_ctx = {
                default = 32768,
              },
              temperature = {
                default = 0.7,
              },
            },
          })
        end,
      },
      display = {
        diff = {
          provider = 'mini_diff',
        },
        chat = {
          window = {
            layout = 'vertical', -- float|vertical|horizontal|buffer
            border = 'rounded',
            height = 0.8,
            width = 0.45,
            relative = 'editor',
          },
          show_settings = true, -- Show model settings in chat buffer
        },
      },
      opts = {
        log_level = 'DEBUG', -- Change to "ERROR" in production
      },
    }
  end,
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat', mode = { 'n', 'v' } },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'Actions', mode = { 'n', 'v' } },
    { '<leader>ci', '<cmd>CodeCompanion<cr>', desc = 'Inline Assistant', mode = { 'n', 'v' } },
    { '<leader>cs', '<cmd>CodeCompanionChat Add<cr>', desc = 'Add to Chat', mode = 'v' },
    { 'ga', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat', mode = { 'n', 'v' } },
  },
}
