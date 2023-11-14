local function config()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },

    json = { "jsonlint" },

    python = { "ruff" },
  }

  local gid = vim.api.nvim_create_augroup("mdx_lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    group = gid,
    desc = "Lint document by nvim-lint",
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = config,
}
