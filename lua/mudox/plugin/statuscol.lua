local function opts()
  local builtin = require("statuscol.builtin")

  local fold = {
    text = {
      builtin.foldfunc,
      " ",
    },
    condition = {
      function(args)
        return vim.wo[args.win].foldenable
      end,
      function(args)
        return vim.wo[args.win].foldenable
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
    sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 1, auto = true },
    click = "v:lua.ScSa",
  }

  local line_num = {
    text = { builtin.lnumfunc, " " },
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

  local other = {
    sign = {
      namespace = { ".*" },
      maxwidth = 1,
      colwidth = 2,
      auto = true,
    },
  }

  return {
    segments = {
      fold,
      -- todo,
      -- diagnostic,
      -- test_debug,
      other,
      line_num,
      gitsigns,
    },
    ft_ignore = { "alpha", "qf" },
  }
end

return {
  "luukvbaal/statuscol.nvim",
  event = "VimEnter", -- need to load before alpha.nvim
  opts = opts,
}
