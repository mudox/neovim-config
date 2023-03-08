-- vim: fdm=marker fmr=\ 〈,\ 〉

local null_ls = require("null-ls")

-- Full list of builtins: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics
local a = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {

    -- Format 〈

    -- JavaScript, TypeScript
    f.prettierd,

    -- Python
    f.black.with { extra_args = { "--fast" } },
    f.isort,

    -- Lua
    f.stylua,

    -- Swift
    f.swiftformat,

    -- Bash, Zsh, Sh
    f.beautysh,

    -- 〉

    -- Lint, diagnostics 〈

    -- TODO: try replacing flake8 with pylama which wraps more linters
    -- d.flake8.with {
    --   extra_args = {
    --     "--extend-ignore=E203", --[[ black pads space around colon ]]
    --   },
    -- },
    d.pylama,

    -- JavaScript, TypeScript
    d.eslint_d, -- ESLint

    -- 〉

    -- Code action 〈

    -- JavaScript, TypeScript
    a.eslint_d, -- ESLint

    -- 〉
  },
}
