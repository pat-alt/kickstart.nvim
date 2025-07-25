-- TODO: Add insert commands to insert comments

-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function()
      require 'custom.config.which-key.setup'
    end,
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>z', ':ZenMode<cr>', desc = '[Z]en mode' },
        { '<leader>m', ':Mtm<cr>', desc = '[M]arkdown table mode' },
        -- Toggle
        { '<leader>te', ':lua require("nabla").popup()<CR>', desc = '[E]quation' },
        {
          '<leader>td',
          function()
            if vim.o.background == 'light' then
              vim.o.background = 'dark'
            else
              vim.o.background = 'light'
            end
          end,
          desc = '[d]ark theme',
        },
        -- Search
        { '<leader>st', ':TodoTelescope<cr>', desc = '[T]odo' },
        -- Search and Replace
        { '<leader>r', group = '[R]eplace' },
        { '<leader>rf', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], desc = 'Search and replace in [f]ile' },
        -- TODO: add find+and replace for project dir
        -- Quarto
        { '<leader>q', group = '[q]uarto' },
        { '<leader>qh', ':QuartoHelp ', desc = '[h]elp' },
        { '<leader>qf', ":lua require'quarto'.quartoPreview({ args = '--port 4242 --no-browser' })<cr>", desc = '[f]ixed port preview' },
        { '<leader>qq', ':QuartoClosePreview<cr>', desc = '[q]uit preview' },
        { '<leader>qp', ':QuartoPreview<cr>', desc = '[p]review' },
        -- Vim
        { '<leader>v', group = '[v]im' },
        { '<leader>vc', ':Telescope colorscheme<cr>', desc = '[c]olortheme' },
        { '<leader>vl', ':Lazy<cr>', desc = '[L]azy' },
        -- Mason
        { '<leader>vm', group = '[M]ason' },
        { '<leader>vmo', ':Mason<cr>', desc = '[O]pen' },
        { '<leader>vmi', ':MasonInstall ', desc = '[I]nstall' },
        -- Persistence
        { '<leader>vp', group = '[P]ersistence' },
        {
          '<leader>vps',
          function()
            require('persistence').select()
          end,
          desc = '[s]elect',
        },
        {
          '<leader>vpl',
          function()
            require('persistence').load()
          end,
          desc = '[l]oad',
        },
        -- Insert comments
        { '<leader>i', group = '[I]nsert' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
