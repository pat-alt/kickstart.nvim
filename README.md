

# Neovim

This is my personal Neovim config originally forked from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and detached in early 2026 to avoid merge nightmares. I started using Neovim in 2025H1, so I’m still very new to this. For this reason, I’m including the following disclaimer here:

> [!WARNING]
> - I'm new to this.
> - You almost definitely do not want to fork this repo for your own config. 
> - I'm currently using this README mostly to jot down notes for myself. 

## Install

To install this config, make sure you backup any existing nvim config and then:

    git clone https://github.com/pat-alt/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

## Julia

Mason cannot properly install Julia LS. Instead, Julia LS is set up through Julia’s own native package manager `Pkg` with a dedicated Julia LS environment:

``` lua
-- Use lspconfig API (works on both nvim 0.10 and 0.11)
require('lspconfig').julials.setup {
  capabilities = capabilities,
  on_new_config = function(new_config, _)
    local server_path = vim.fn.expand("~/.julia/environments/nvim-lspconfig")
    if not require('lspconfig.util').path.is_dir(server_path) then
      vim.notify(
        'Julia LS: Creating environment at ' .. server_path,
        vim.log.levels.INFO
      )
      vim.fn.system({
        'julia',
        '--startup-file=no',
        '--history-file=no',
        '--project=' .. server_path,
        '-e',
        'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer")',
      })
    end
  end,
}
```

The environment is created as follows:

``` bash
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer")'
```

If everything is set up correctly, you should have autocomplete in the following Julia cell:

``` julia
println("hello")
```

    hello

> \[!warning\] Deprecated `lspconfig` API This is using the `lspconfig` API which will be deprecated in future versions of nvim.

## Papis (bibliography management)

[`papis.nvim`](https://github.com/jghauser/papis.nvim) integrates the [Papis](https://papis.readthedocs.io/) bibliography manager into Neovim (see `lua/custom/plugins/papis.lua`). On a new machine, the following system-level setup is needed before the plugin will work:

1.  **Install the `papis` CLI** (Python package):

    ``` bash
    pipx install papis   # or: pip install --user papis
    ```

2.  **Create a Papis config** at `~/.config/papis/config` with at least one library pointing at a directory of references, e.g.:

    ``` ini
    [papers]
    dir = ~/Documents/papers

    [settings]
    default-library = papers
    ```

3.  **Ensure `sqlite3` is available** on the system — `papis.nvim` depends on [`kkharji/sqlite.lua`](https://github.com/kkharji/sqlite.lua), which needs the system `libsqlite3` library (on macOS: `brew install sqlite`; on most Linux distros it is already installed).

4.  **Luarocks is disabled** for `lazy.nvim` (`rocks = { enabled = false, hererocks = false }` in `lua/lazy-plugins.lua`) — both `papis.nvim` and `sqlite.lua` are loaded with `build = false` so no `luarocks`/`hererocks` toolchain is required.

Once these are in place, open a supported filetype (`markdown`, `quarto`, `rmd`, `typst`, `norg`, `yaml`) and run `:Papis` to trigger the plugin; cite-key completion is wired through `nvim-cmp`.

## Best Practices … maybe

### Lazy

- Use `opts` to specify config options. Use `config` only for more complex configurations.
