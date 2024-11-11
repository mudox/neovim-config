local function config()
  local lint = require("lint")

  -- stylua: ignore
  lint.linters_by_ft = {
    lua        = { "selene", "typos" },

    javascript = { "eslint_d" },
    typescript = { "eslint_d" },

    json       = { "jsonlint" },

    python     = { "typos"     },

    rust       = { "typos"     },
  }

  local gid = vim.api.nvim_create_augroup("mdx_lint", { clear = true })
  On({ "BufEnter", "BufWritePost" }, {
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
  keys = {
    {
      "\\l",
      function()
        require("lint").try_lint()
      end,
      desc = "[Lint] lint",
    },
  },
  config = config,
}
