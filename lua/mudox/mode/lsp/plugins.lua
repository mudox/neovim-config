-- vim: fdm=marker fmr=〈,〉

return {

  -- Boost startup time
  "impatient", -- track https://github.com/neovim/neovim/pull/15436

  -- The Plugin manager
  "packer",

  -- Keymap
  "which-key",
  "hydra",

  -- Dev
  "plenary",
  "repeat",
  "startup-time",

  -- Tree-sitter
  "tree-sitter",
  "context",

  "context-vt",
  "aerial",

  "neogen",
  "trev-j",
  "refactoring",

  "neoformat",

  -- LSP
  "fix-cursor-hold", -- For highlight cursor
  "lsp",
  "null-ls",

  "inc-rename",

  -- Completion
  "cmp",
  "copilot",

  -- Debugging
  "dap",
  "dap-ui",
  "dap-virtual-text",

  -- Testing
  "vim-test",
  "neo-test",

  -- Editing
  "capslock",

  "visual-multi",

  "comment",
  "switch",

  "auto-pairs",
  "sandwich",

  "easy-align",

  "neo-clip",

  "spectre",

  -- Snippets
  "luasnip",

  -- UI
  "dev-icons",
  "base16",
  "colorizer",

  "dressing",

  "lualine",

  "pretty-fold",

  "indent-blank-line",

  "todo-comments",

  "trouble",

  -- Window & Panes
  "popup",

  "window-picker",

  "notify",

  "toggle-term",

  -- File Explorer
  "nnn",
  "tree",

  -- Navigation
  "light-speed",
  "tree-hopper",

  "telescope",

  -- "marks",
  "reach",
  "other",

  -- Tmux
  "tmux-navigator",
  -- "tmuxline",

  -- Text object
  -- "textobject/*",

  -- File type
  -- "filetype/*",

  -- Other
  "unimpaired",

  -- Git
  "fugitive",

  "diff-view",
  "git-signs",

  -- Language
  -- "iron",

  -- Lua
  "lua-ref",
  "lua-pad",

  -- Swift

  -- Rust
  -- "rust-tools",
  -- TODO: https://github.com/Saecki/crates.nvim

  -- Python
  "dap-python",

  -- JavaScript

  -- TypeScript
  -- LATER: https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils

  -- HTML/CSS
  "emmet",

  -- C/C++
}
