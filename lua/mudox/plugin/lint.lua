local function config()
  local lint = require("lint")

  -- stylua: ignore
  lint.linters_by_ft = {
    lua        = { "selene", "typos" },

    javascript = { "quick-lint-js"   },
    typescript = { "quick-lint-js"   },

    json       = { "jsonlint"        },

    python     = { "typos"           },

    rust       = { "typos"           },
  }

  local gid = vim.api.nvim_create_augroup("mdx_lint", { clear = true })
  On({ "BufEnter", "BufWritePost" }, {
    group = gid,
    desc = "Lint document by nvim-lint",
    callback = function(event)
      if vim.b.auto_lint == false or vim.g.auto_lint == false then
        return
      end

      local ft = vim.bo[event.buf].filetype

      local backlist_fts = { "json.kulala_ui" }
      if vim.tbl_contains(backlist_fts, ft) then
        return
      end

      require("lint").try_lint()
    end,
  })
end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "\\l", function() require("lint").try_lint() end, desc = "[Lint] lint" },
  },
  config = config,
}
