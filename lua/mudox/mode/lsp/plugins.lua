-- vim: fdm=marker fmr=\ 〈,\ 〉

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
  "lsp-saga",
  "lsp-lines",
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
  "rsi",

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

  "true-zen",

  "window-picker",

  "notify",

  "scroll-view",

  -- Terminal & Tasks
  "toggle-term",

  "overseer",

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
  "snip-run",

  -- Lua
  "lua-dev", -- neovim lua api help, signature for lsp
  "lua-ref", -- lua runtime, stdlib help, signature
  "lua-pad", -- lua repl

  -- Swift
  -- INFO: compile failed with my tuist local plugin
  -- "xbase",

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
