return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = 'ollama',
        opts = {
          model = 'qwen3:4b',
        },
      },
      inline = {
        adapter = 'ollama',
        opts = {
          model = 'starcoder2:3b',
        },
      },
      cmd = {
        adapter = 'ollama',
        opts = {
          model = 'starcoder2:3b',
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function(_, opts)
    require('codecompanion').setup(opts)

    -- Set keymaps for CodeCompanion
    vim.keymap.set({ 'n', 'v' }, '<C-;>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
    vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
}
