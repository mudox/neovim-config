local null_ls = require("null-ls")

local f = null_ls.builtins.formatting
local d = null_ls.builtins.diagnostics
local a = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    -- formatting
    f.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    f.black.with { extra_args = { "--fast" } }, -- Python
    f.stylua, -- Lua
    f.swiftformat, -- Swift

    -- diagnostics
    d.flake8, -- Python flake8
    d.eslint_d, -- ESLint

    -- code actions
    a.eslint_d, -- ESLint
  },
}
