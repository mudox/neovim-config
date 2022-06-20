local null_ls = require("null-ls")

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics
local a = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    f.prettier.with {
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },

    -- Python
    f.black.with { extra_args = { "--fast" } },
    f.isort,

    -- Lua
    f.stylua,

    -- Swift
    f.swiftformat,

    -- Diagnostics
    d.flake8.with {
      extra_args = {
        "--extend-ignore=E203", --[[ black pads space around colon ]]
      },
    },
    d.eslint_d, -- ESLint

    -- code actions
    a.eslint_d, -- ESLint
  },
}
