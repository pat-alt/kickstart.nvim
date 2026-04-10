return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Fix diagnostics section for Neovim 0.8 (vim.diagnostic.is_disabled
      -- requires 0.9+, vim.diagnostic.is_enabled requires 0.10+)
      if vim.fn.has 'nvim-0.9' == 0 then
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_diagnostics = function(args)
          if statusline.is_truncated(args.trunc_width) then
            return ''
          end
          local count = {}
          for _, d in ipairs(vim.diagnostic.get(0)) do
            count[d.severity] = (count[d.severity] or 0) + 1
          end
          local severity = vim.diagnostic.severity
          local levels = {
            { name = 'ERROR', sign = 'E' },
            { name = 'WARN', sign = 'W' },
            { name = 'INFO', sign = 'I' },
            { name = 'HINT', sign = 'H' },
          }
          local t = {}
          for _, level in ipairs(levels) do
            local n = count[severity[level.name]] or 0
            if n > 0 then
              table.insert(t, ' ' .. level.sign .. n)
            end
          end
          if #t == 0 then
            return ''
          end
          return (vim.g.have_nerd_font and '' or 'Diag') .. table.concat(t, '')
        end
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
