return {
  'jghauser/papis.nvim',
  build = false,
  dependencies = {
    { 'kkharji/sqlite.lua', build = false },
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
  },
  ft = { 'markdown', 'norg', 'yaml', 'typst', 'quarto', 'rmd' },
  cmd = 'Papis',
  config = function()
    require('papis').setup {
      enable_keymaps = true,
      init_filetypes = { 'markdown', 'norg', 'yaml', 'typst', 'quarto', 'rmd' },
    }
  end,
}
