local function ollama_available()
  local ok, handle = pcall(io.popen, 'curl -s -o /dev/null -w "%{http_code}" http://localhost:11434/api/tags 2>/dev/null')
  if not ok or not handle then
    return false
  end
  local status = handle:read '*a'
  handle:close()
  return status == '200'
end

-- Custom inline_output handler that strips code fences the model
-- sometimes embeds inside the JSON code field. Handles both OpenAI
-- (json.choices[1].message.content) and Ollama (json.message.content) formats.
local function clean_inline_output(self, data)
  if data and data ~= '' then
    local ok, json = pcall(vim.json.decode, data.body, { luanil = { object = true } })
    if not ok then
      return { status = 'error', output = json }
    end
    local content
    if json.choices and json.choices[1] and json.choices[1].message then
      content = json.choices[1].message.content
    elseif json.message then
      content = json.message.content
    end
    if content then
      local cok, cjson = pcall(vim.json.decode, content, { luanil = { object = true } })
      if cok and type(cjson) == 'table' and cjson.code then
        cjson.code = cjson.code:gsub('^```%w*\n', ''):gsub('\n```%s*$', '')
        content = vim.json.encode(cjson)
      end
      return { status = 'success', output = content }
    end
  end
end

return {
  'olimorris/codecompanion.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
  },
  config = function()
    local has_litellm = vim.env.LITELLM_API_KEY and vim.env.LITELLM_API_KEY ~= ''
    local has_ollama = not has_litellm and ollama_available()

    if not has_litellm and not has_ollama then
      vim.notify('[codecompanion] No backend available (no LITELLM_API_KEY, Ollama not running)', vim.log.levels.WARN)
      return
    end

    local adapters, chat_adapter, inline_adapter

    if has_litellm then
      chat_adapter = 'litellm'
      inline_adapter = 'litellm_inline'
      adapters = {
        http = {
          litellm = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                api_key = 'LITELLM_API_KEY',
                url = 'https://litellm.prod.hbk.com',
              },
              schema = {
                model = {
                  default = 'claude-sonnet-4-6',
                },
              },
            })
          end,
          litellm_inline = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                api_key = 'LITELLM_API_KEY',
                url = 'https://litellm.prod.hbk.com',
              },
              opts = {
                stream = false,
              },
              schema = {
                model = {
                  default = 'claude-sonnet-4-6',
                },
              },
              handlers = {
                inline_output = clean_inline_output,
              },
            })
          end,
        },
      }
      vim.notify('[codecompanion] Using LiteLLM backend', vim.log.levels.INFO)
    else
      chat_adapter = 'ollama'
      inline_adapter = 'ollama_inline'
      adapters = {
        http = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'http://127.0.0.1:11434',
              },
              schema = {
                model = {
                  default = 'qwen2.5-coder:7b',
                },
              },
            })
          end,
          ollama_inline = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'http://127.0.0.1:11434',
              },
              opts = {
                stream = false,
              },
              schema = {
                model = {
                  default = 'qwen2.5-coder:7b',
                },
              },
              handlers = {
                inline_output = clean_inline_output,
              },
            })
          end,
        },
      }
      vim.notify('[codecompanion] Using Ollama backend', vim.log.levels.INFO)
    end

    require('codecompanion').setup {
      opts = {
        log_level = 'ERROR',
      },
      adapters = adapters,
      interactions = {
        chat = { adapter = chat_adapter },
        inline = { adapter = inline_adapter },
      },
      display = {
        chat = {
          window = {
            layout = 'vertical',
            border = 'rounded',
            height = 0.8,
            width = 0.45,
            relative = 'editor',
          },
          show_settings = true,
        },
      },
    }

    -- Keymaps registered after setup
    vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI Chat toggle' })
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'AI Actions' })
    vim.keymap.set('n', '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'AI Inline assistant' })
    vim.keymap.set('v', '<leader>ai', ":'<,'>CodeCompanion<cr>", { desc = 'AI Inline assistant' })
    vim.keymap.set('v', '<leader>as', ":'<,'>CodeCompanionChat Add<cr>", { desc = 'AI Add selection to chat' })
    vim.keymap.set({ 'n', 'v' }, 'ga', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle AI Chat' })
  end,
}
