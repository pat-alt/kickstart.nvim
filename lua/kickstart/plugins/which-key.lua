-- which-key v1 for Neovim 0.8 compatibility

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    version = '1.*',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {}
      require 'custom.config.which-key.setup'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
