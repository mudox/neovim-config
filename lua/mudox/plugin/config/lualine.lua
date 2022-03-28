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
  component_separators = { left = "", right = "" },
  section_separators = { left = "", right = "" },
  -- section_separators = {left = '', right = ''},
  -- component_separators = {left = '', right = ''},

  disabled_filetypes = {},
  always_divide_middle = true,
}

-- stylua: ignore start
local sections = {
  lualine_a = {
    { "mode",         },
    { "filename",     },
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

local tabline = {
  lualine_a = { { "buffers" } },
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
  sections = sections,
  inactive_sections = inactive_sections,
  tabline = tabline,
  extensions = {},
}
