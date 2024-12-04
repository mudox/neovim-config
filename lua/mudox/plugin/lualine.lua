local sep = I.powerline.current

local options = {
  globalstatus = true,

  icons_enabled = true,

  theme = (function()
    local theme = require("lualine.themes.molokai")
    theme.normal.c.bg = "bg"
    return theme
  end)(),

  component_separators = {
    left = sep.light_left,
    right = sep.light_right,
  },
  section_separators = {
    left = sep.heavy_left,
    right = sep.heavy_right,
  },

  disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
  always_divide_middle = true,
}

local statusline = {
  lualine_a = {
    { "mode" },
  },
  lualine_b = {
    { "branch", icon = "┣" },
  },
  lualine_c = {
    { "filename" },
  },

  lualine_x = {
    { "diagnostics", symbols = I.diagnostics.single },
    { "filetype" },
  },
  lualine_y = {
    { "progress", separator = " ", padding = { left = 1, right = 1 } },
  },
  lualine_z = {
    { "location", padding = { left = 0, right = 0 } },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  cond = function()
    return not _G.mdx_config.noice
  end,
  -- event = "VeryLazy", -- loaded by `alpha.nvim` automatically
  opts = {
    options = options,
    sections = statusline,
  },
}
