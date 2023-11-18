local function opts()
  local builtin = require("statuscol.builtin")

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

  local diagnostics = {
    sign = {
      name = {
        "Diagnostic",
      },
      maxwidth = 1,
      colwidth = 2,
      auto = true,
    },
    click = "v:lua.ScSa",
  }

  local gap = {
    text = { " " },
    condition = builtin.not_empty,
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

  return {
    segments = {
      diagnostics,
      test_debug,
      line_num,
      gitsigns,
    },
  }
end

return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  opts = opts,
}
