-- Extra colorschemes, pickable via `<leader>vc` (`:Telescope colorscheme`).
-- Your active theme is still set in `lua/kickstart/plugins/tokyonight.lua`.
return {
  -- `lazy = false` so their `colors/` dirs register at startup and show up in
  -- `:Telescope colorscheme`. No setup code runs until a theme is selected.
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 100 },
  { 'rebelot/kanagawa.nvim', lazy = false, priority = 100 },
  { 'EdenEast/nightfox.nvim', lazy = false, priority = 100 },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 100 },
  { 'sainnhe/everforest', lazy = false, priority = 100 },
  { 'navarasu/onedark.nvim', lazy = false, priority = 100 },
  { 'Mofiqul/vscode.nvim', lazy = false, priority = 100 },
  { 'ellisonleao/gruvbox.nvim', lazy = false, priority = 100 },
}
