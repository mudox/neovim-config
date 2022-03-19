local options = {
  globalstatus = true,
  icons_enabled = true,

  -- themes
  -- theme = 'gruvbox',
  -- theme = 'auto',
  theme = "ayu_mirage",

  -- separators
  component_separators = { left = "", right = "" },
  section_separators = { left = "", right = "" },
  -- section_separators = {left = '', right = ''},
  -- component_separators = {left = '', right = ''},

  disabled_filetypes = {},
  always_divide_middle = true,
}

local function cond1()
  local disabled_filetypes = {
    dapui_scopes = true,
    dapui_breakpoints = true,
    dapui_stacks = true,
    dapui_watches = true,
  }

  return not disabled_filetypes[vim.o.filetype]
end

local function cond2()
  local enabled_filetypes = {
    dapui_scopes = true,
    dapui_breakpoints = true,
    dapui_stacks = true,
    dapui_watches = true,
  }

  return enabled_filetypes[vim.o.filetype]
end

-- stylua: ignore start
local sections = {
  lualine_a = {
    { "mode",        cond = cond1 },
    { "filename",    cond = cond2 },
  },
  lualine_b = {
    { "branch",      cond = cond1 },
    { "diff",        cond = cond1 },
  },
  lualine_c = {
    { "filename",    cond = cond1 },
  },
  lualine_x = {
    { "lsp_progress", cond = cond1 },
    { "diagnostics", cond = cond1 },
    { "filetype",    cond = cond1 },
  },
  lualine_y = {
    { "progress",    cond = cond1 },
  },
  lualine_z = {
    { "location",    cond = cond1 },
  },
}
-- stylua: ignore end

local tabline = {
  lualine_a = { { "buffers", mode = 2 } },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = { [[ vim.g.mdx_nvim_mode .. ' ' ]] },
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
