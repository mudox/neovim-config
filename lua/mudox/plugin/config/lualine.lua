local i = require("mudox.ui").icons
local sep = i.powerline.current

local options = {
  globalstatus = true,

  icons_enabled = true,

  -- Theme
  -- theme = "auto",
  -- theme = "gruvbox",
  -- theme = "horizon",
  theme = "molokai",
  -- theme = "ayu_mirage",

  -- Separators
  component_separators = {
    left = sep.light_left,
    right = sep.light_right,
  },
  section_separators = {
    left = sep.heavy_left,
    right = sep.heavy_right,
  },

  disabled_filetypes = {},
  always_divide_middle = true,
}

-- stylua: ignore start
local sections = {
  lualine_a = {
    { "mode",         },
  },
  lualine_b = {
    { "branch",       },
    { "diff",         },
  },
  lualine_c = {
    { "filename",     },
    { "aerial", sep = '  ', depth = -2, dense = false, },
  },
  lualine_x = {
    -- { "lsp_progress",  },
    { "diagnostics",  },
    { "filetype",     },
  },
  lualine_y = {
    { "progress",     },
  },
  lualine_z = {
    { "location",     },
  },
}
-- stylua: ignore end

local buffers = {

  "buffers",

  show_filename_only = true,
  hide_filename_extension = true,

  filetype_names = {
    TelescopePrompt = "[telescope]",
    packer = "[packer]",
    aerial = "[aerial]",
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

local inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { "filename" },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}

require("lualine").setup {
  options = options,

  tabline = tabline,
  sections = sections,
  inactive_sections = inactive_sections, -- no need for global statusline

  extensions = {},
}
