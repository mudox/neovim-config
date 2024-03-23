local function opts()
  local builtin = require("statuscol.builtin")

  local fold = {
    text = {
      builtin.foldfunc,
      " ",
    },
    condition = {
      function()
        return vim.wo.foldenable
      end,
      function(args)
        return vim.wo.foldenable
        -- return args.fold.width > 0
      end,
    },
    click = "v:lua.ScFa",
  }

  local todo = {
    sign = {
      name = { "todo" },
      maxwidth = 1,
      colwidth = 2,
      auto = true,
    },
    click = "v:lua.ScSa",
  }

  local test_debug = {
    sign = {
      name = {
        "Dap",
        "neotest",
      },
      maxwidth = 1,
      colwidth = 2,
      auto = true,
    },
    click = "v:lua.ScSa",
  }

  local diagnostic = {
    -- use `:=vim.api.nvim_buf_get_extmarks(0, -1, 0, -1, { details = true})` to get all placed
    -- extmarks with their namespaces
    sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 2, auto = true },
    click = "v:lua.ScSa",
  }

  local line_num = {
    text = { builtin.lnumfunc },
    click = "v:lua.ScLa",
  }

  local gitsigns = {
    sign = {
      namespace = { "gitsigns_extmark_signs_" },
      maxwidth = 1,
      colwidth = 1,
      auto = true,
    },
    click = "v:lua.ScSa",
  }

  local fallback = {
    sign = {
      name = { ".*" },
      maxwidth = 2,
      colwidth = 1,
      auto = true,
    },
  }

  return {
    segments = {
      fold,
      -- todo,
      diagnostic,
      test_debug,
      line_num,
      gitsigns,
      fallback,
    },
  }
end

return {
  "luukvbaal/statuscol.nvim",
  event = { "BufNewFile", "BufRead" },
  opts = opts,
}
