local sep = I.powerline.current

local options = {
  globalstatus = true,

  icons_enabled = true,

  theme = "molokai",

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
  -- event = "UIEnter", -- auto loaded by alpha.nvim as a dependency
  opts = {
    options = options,
    sections = statusline,
  },
  cond = not C.noice,
}
