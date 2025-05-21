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

-- Open new terminal
local function new_terminal(lang)
  vim.cmd('vsplit term://' .. lang)
end

local function new_terminal_python()
  new_terminal 'python'
end

local function new_terminal_r()
  new_terminal 'R --no-save'
end

local function new_terminal_julia()
  new_terminal 'julia'
end

--show keybindings with whichkey
--add your own here if you want them to
--show up in the popup as well

-- normal mode
wk.add({
  { '<leader>i', group = 'Insert' },
  { '<c-i>', insert_julia_chunk, desc = 'Julia chunk' },
  { '<leader>ij', insert_julia_chunk, desc = '[J]ulia chunk' },
  { '<leader>ip', insert_py_chunk, desc = '[P]ython chunk' },
  { '<leader>ir', insert_r_chunk, desc = '[R] chunk' },
  { '<leader>il', insert_lua_chunk, desc = '[L]ua chunk' },
  { '<leader>cj', new_terminal_julia, desc = 'New [J]ulia terminal' },
  { '<leader>cp', new_terminal_python, desc = 'New [P]ython terminal' },
  { '<leader>cr', new_terminal_r, desc = 'New [R] terminal' },
}, { mode = 'n' })
