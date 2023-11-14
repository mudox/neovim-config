local function opts()
  local builtin = require("statuscol.builtin")

  local signs = {
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

  local space = { text = { " " } }

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
      signs,
      line_num,
      gitsigns,
    },

    relculright = false,
    setopt = true,
    ft_ignore = {
      "help",
      "vim",
      "fugitive",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "noice",
      "lazy",
      "toggleterm",
    },
  }
end

return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  opts = opts,
}
