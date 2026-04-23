return {
  'urtzienriquez/citeref.nvim',
  ft = { 'markdown', 'rmd', 'quarto', 'rnoweb', 'pandoc', 'tex', 'latex' },
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('citeref').setup {
      backend = 'cmp',
      bib_files = function()
        return vim.fn.glob(vim.fn.getcwd() .. '/**/*.bib', false, true)
      end,
    }
  end,
}
