local wk = require 'which-key'

local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_r_chunk = function()
  insert_code_chunk 'r'
end

local insert_py_chunk = function()
  insert_code_chunk 'python'
end

local insert_lua_chunk = function()
  insert_code_chunk 'lua'
end

local insert_julia_chunk = function()
  insert_code_chunk 'julia'
end

-- Open new terminal (tmux pane)
local function new_terminal(lang)
  local cmd = string.format("tmux split-window -h '%s'", lang)
  os.execute(cmd)
end

local function new_terminal_python()
  new_terminal 'python || python3'
end

local function new_terminal_r()
  new_terminal 'R --no-save'
end

local function new_terminal_julia()
  new_terminal 'julia --project'
end

local function new_terminal_julia_release()
  new_terminal 'julia +release --project'
end

-- normal mode
wk.register({
  i = { name = '+Insert' },
  ij = { insert_julia_chunk, '[J]ulia chunk' },
  ip = { insert_py_chunk, '[P]ython chunk' },
  ir = { insert_r_chunk, '[R] chunk' },
  il = { insert_lua_chunk, '[L]ua chunk' },
  cj = { new_terminal_julia, 'New [J]ulia terminal' },
  cJ = { new_terminal_julia_release, 'New [J]ulia terminal ([r]elease channel)' },
  cp = { new_terminal_python, 'New [P]ython terminal' },
  cr = { new_terminal_r, 'New [R] terminal' },
}, { prefix = '<leader>' })

-- <c-i> mapping (no leader prefix)
wk.register {
  ['<c-i>'] = { insert_julia_chunk, 'Julia chunk' },
}
