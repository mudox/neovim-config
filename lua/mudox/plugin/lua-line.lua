local i = require("mudox.ui").icons
local sep = i.powerline.current

local options = {
  globalstatus = true,

  icons_enabled = true,

  -- Theme
  -- theme = "auto",
  -- theme = "gruvbox",
  -- theme = "horizon",
  -- theme = "ayu_mirage",
  theme = "molokai",

  -- Separators
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

local navic = {
  function()
    return require("nvim-navic").get_location()
  end,
  cond = function()
    return require("nvim-navic").is_available()
  end,
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
    { "b:toggle_number" },
    -- navic, -- prefer `dropbar.nvim` instead
  },

  lualine_x = {
    { "diagnostics" },
    { "filetype" },
  },
  lualine_y = {
    { "progress", separator = " ", padding = { left = 1, right = 1 } },
  },
  lualine_z = {
    { "location", padding = { left = 0, right = 0 } },
  },
}

local buffers = {
  "buffers",

  show_filename_only = true,
  hide_filename_extension = true,

  filetype_names = {
    TelescopePrompt = "[telescope]",
    packer = "[packer]",
    aerial = "[aerial]",
    fugitive = "[fugitive]",
  },

  symbols = {
    modified = " 󰴓 ",
    alternate_file = "⎇  ",
    directory = " ",
  },
}

local tabline = {
  lualine_a = { buffers },
  lualine_b = {},
  lualine_c = {},
  lualine_x = { [[ vim.g.mdx_nvim_mode .. ' ' ]] },
  lualine_y = {},
  lualine_z = { "tabs" },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = options,
    sections = statusline,
    tabline = tabline,
  },
}
