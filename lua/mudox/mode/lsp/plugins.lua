-- vim: fdm=marker fmr=〈,〉

return {
  -- Boost startup time
  "impatient", -- it will be merged into Neovim
  "filetype", -- replace `runtime/filetype.vim`

  -- The Plugin manager
  "packer",

  -- Dev
  "plenary",
  "repeat",
  "startup-time",

  -- Language
  "tree-sitter",

  "context-vt",
  "aerial",

  "neoformat",

  "trouble",

  -- LSP 〈

  -- lsp basics
  "lsp-config",
  "lsp-installer",
  "null-ls",

  -- the completion engine
  "cmp",

  -- basic sources
  "cmp-buffer", -- words from buffers
  "cmp-cmdline", -- neovim commands completion
  "cmp-path", -- filesystem path completion

  -- snippets
  "cmp-luasnip",

  -- neovim lua api
  "cmp-nvim-lua",

  -- generic completion sources
  "cmp-nvim-lsp",
  "cmp-tabnine",

  -- 〉

  -- Debugging
  -- "dap",

  -- Editing
  "visual-multi",

  "comment",
  "switch",

  "auto-pairs",
  "sandwich",

  "easy-align",

  -- Search & replace
  "spectre",

  -- Snippets
  "luasnip",
  -- "ultisnips",
  -- "snippets",

  -- UI
  "git-signs",
  "notify",
  "which-key",
  "dressing",
  "dev-icons",
  "base16",
  "lualine",
  "tmuxline",
  "indent-blank-line",
  "todo-comments",
  "shade",

  -- Window
  "stickybuf",
  "popup",

  "zen-mode",

  -- Navigation
  "clever-f",
  "light-speed",
  "nnn",
  "telescope",
  "tmux-navigator",
  "tree-hopper",

  -- Text object
  "textobject/*",

  -- File type
  "filetype/*",

  -- Other
  "unimpaired",

  -- Git
  "fugitive",

  -- Web
  "emmet",

  -- Lua
  "luapad",

  -- Swift
  -- Rust
  -- Python
  -- JS
  -- HTML/CSS
  -- C/C++
}
