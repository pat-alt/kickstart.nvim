-- Set terminal background
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    -- Force dark background for terminal windows only
    vim.api.nvim_win_set_option(0, 'winhighlight', 'Normal:TermNormal,CursorLine:TermCursorLine')
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    -- Set terminal default text colors
    vim.api.nvim_set_hl(0, 'TermNormal', {
      bg = '#1a1b26', -- Tokyonight night theme background
      fg = '#a0b1ec',
    })

    -- Set cursor line highlight in terminal
    vim.api.nvim_set_hl(0, 'TermCursorLine', {
      bg = '#44475a', -- subtle purple-gray line
    })

    vim.g.terminal_color_2 = '#70e280' -- make sure green is green!
  end,
})
