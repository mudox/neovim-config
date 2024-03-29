-- TODO: favor nvim-lint & conform over null-ls

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

      -- Python
      -- f.black.with { extra_args = { "--fast" } },
      -- f.isort,

      -- Swift
      f.swiftformat,
    },
  }
end

return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = { { "<leader>vn", "<Cmd>NullLsInfo<Cr>", desc = "Null" } },
  opts = opts,
}
