local function opts()
  local builtin = require("statuscol.builtin")

  local fold = { text = { builtin.foldfunc }, click = "v:lua.ScFa" }

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
    sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 2, auto = true },
    click = "v:lua.ScSa",
  }

  local gap = {
    text = { " " },
    condition = { builtin.not_empty },
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
      -- fold,
      todo,
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
  event = "VeryLazy",
  opts = opts,
}
