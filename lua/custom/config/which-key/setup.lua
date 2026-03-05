local wk = require 'which-key'

require 'custom.config.which-key.code'

-- normal mode
wk.register({
  c = { name = '+[C]ode' },
  d = { name = '+[D]ocument' },
  s = { name = '+[S]earch' },
  w = { name = '+[W]orkspace' },
  t = { name = '+[T]oggle' },
  h = { name = '+Git [H]unk' },
  z = { ':ZenMode<cr>', '[Z]en mode' },
  m = { ':Mtm<cr>', '[M]arkdown table mode' },
  -- Toggle
  te = { ':lua require("nabla").popup()<CR>', '[E]quation' },
  td = {
    function()
      if vim.o.background == 'light' then
        vim.o.background = 'dark'
      else
        vim.o.background = 'light'
      end
    end,
    '[d]ark theme',
  },
  -- Search
  st = { ':TodoTelescope<cr>', '[T]odo' },
  -- Search and Replace
  r = { name = '+[R]eplace' },
  -- Quarto
  Q = { name = '+[q]uarto' },
  Qh = { ':QuartoHelp ', '[h]elp' },
  Qf = { ":lua require'quarto'.quartoPreview({ args = '--port 4242 --no-browser' })<cr>", '[f]ixed port preview' },
  Qq = { ':QuartoClosePreview<cr>', '[q]uit preview' },
  Qp = { ':QuartoPreview<cr>', '[p]review' },
  -- Vim
  v = { name = '+[v]im' },
  vc = { ':Telescope colorscheme<cr>', '[c]olortheme' },
  vl = { ':Lazy<cr>', '[L]azy' },
  -- Mason
  vm = { name = '+[M]ason' },
  vmo = { ':Mason<cr>', '[O]pen' },
  vmi = { ':MasonInstall ', '[I]nstall' },
  -- Persistence
  vp = { name = '+[P]ersistence' },
  vps = {
    function()
      require('persistence').select()
    end,
    '[s]elect',
  },
  vpl = {
    function()
      require('persistence').load()
    end,
    '[l]oad',
  },
  -- Insert comments
  i = { name = '+[I]nsert' },
}, { prefix = '<leader>' })

-- Git hunk group also in visual mode
wk.register({
  h = { name = '+Git [H]unk' },
}, { prefix = '<leader>', mode = 'v' })
