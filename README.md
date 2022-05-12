# MY Neovim's Configuration

# Goal & Status

- Migrate config codebase from VimScript to Lua for fast startup time and performance
- Migrate plugin manager from [vim-plug][5] to [packer.nvim][4]
- Migrate LSP toolkit from [coc.nvim][1] to Neovim built-in LSP + [nvim-cmp][2]
  combination
- Embrace [nvim-treesitter][3]
- Keep config code synced with nightly build, using most updated Neovim API

# Screenshots

### Lua

![dap](screenshot/lua.png)

### Rust

![dap](screenshot/rust.png)

### Diff

![dap](screenshot/diff.png)

### DAP

![dap](screenshot/dap.png)

### Neog

![snapshot](screenshot/neorg.png)

# Core Plugins

### Libraries

[plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | [popup.nvim](https://github.com/nvim-lua/popup.nvim) | [dressing.nvim](https://github.com/stevearc/dressing.nvim)

### Plugin manager

[packer.nvim](https://github.com/wbthomason/packer.nvim)

### Performance

[startuptime.nvim](https://github.com/tweekmonster/startuptime.vim) | [impatient.nvim](https://github.com/lewis6991/impatient.nvim) | [filetype.nvim](https://github.com/nathom/filetype.nvim) | [FixCursorHold.nvim](https://github.com/antoinemadec/FixCursorHold.nvim)

### UI

[nvim-base16.lua](https://github.com/NvChad/nvim-base16.lua) | [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua) | [nnn.nvim](https://github.com/luukvbaal/nnn.nvim) | [aerial.nvim](https://github.com/stevearc/aerial.nvim) | [trouble.nvim](https://github.com/folke/trouble.nvim) | [nvim_context_vt](https://github.com/haringsrob/nvim_context_vt) | [pretty-fold.nvim](https://github.com/anuvyklack/pretty-fold.nvim) | [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | [zen-mode.nvim](https://github.com/folke/zen-mode.nvim) | [tmuxline.vim](https://github.com/edkolev/tmuxline.vim) | [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | [nvim-notify](https://github.com/rcarriga/nvim-notify) | [which-key.nvim](https://github.com/folke/which-key.nvim)

### Editing

[vim-easy-align](https://github.com/junegunn/vim-easy-align) | [vim-sandwich](https://github.com/machakann/vim-sandwich) | [lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim) | [neoformat](https://github.com/sbdchd/neoformat) | [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | [nvim-spectre](https://github.com/windwp/nvim-spectre) | [Comment.nvim](https://github.com/numToStr/Comment.nvim) | [switch.vim](https://github.com/AndrewRadev/switch.vim)

### LSP & completion

[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) | [copilot.vim](https://github.com/github/copilot.vim) | [cmp-tabnine](https://github.com/tzachar/cmp-tabnine) | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)

### Test & debug

[nvim-dap](https://github.com/mfussenegger/nvim-dap) | [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | [ultest](https://github.com/rcarriga/vim-ultest)

### Git

[vim-fugitive](https://github.com/tpope/vim-fugitive) | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | [diffview.nvim](https://github.com/sindrets/diffview.nvim)

### Notes

[Neorg](https://github.com/nvim-neorg/neorg)

### Snippets

[LuaSnip](https://github.com/L3MON4D3/LuaSnip)

### Terminal & tmux

[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

## Other

[vim-unimpaired](https://github.com/tpope/vim-unimpaired) | [vim-repeat](https://github.com/tpope/vim-repeat)

## Languages

### Web

[emmet-vim](https://github.com/mattn/emmet-vim)

### Swift

[swift.vim](https://github.com/keith/swift.vim)

### Lua

[nvim-luapad](https://github.com/rafcamlet/nvim-luapad)

### Python

[nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)

### Rust

[rust-tools](https://github.com/simrat39/rust-tools.nvim)

[1]: https://github.com/neoclide/coc.nvim
[2]: https://github.com/hrsh7th/nvim-cmp
[3]: https://github.com/nvim-treesitter/nvim-treesitter
[4]: https://github.com/wbthomason/packer.nvim
[5]: https://github.com/junegunn/vim-plug
