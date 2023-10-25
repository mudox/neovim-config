local function opts()
  local null = require("null-ls")

  local f = null.builtins.formatting
  local d = null.builtins.diagnostics
  local a = null.builtins.code_actions

  return {
    debug = false,
    sources = {
      -- JavaScript, TypeScript
      f.prettierd,
      d.eslint_d,
      a.eslint_d,

      -- Python
      f.black.with { extra_args = { "--fast" } },
      f.isort,
      d.pylama,

      -- Lua
      -- f.stylua, -- use conform.nvim instead

      -- Swift
      f.swiftformat,

      -- Bash, Zsh, Sh
      f.beautysh,
    },
  }
end

return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = { { "<leader>vn", "<Cmd>NullLsInfo<Cr>", desc = "Null" } },
  opts = opts,
}
