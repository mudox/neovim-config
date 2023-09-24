local function borderless_telescope(hl, c)
  local prompt = "#2d3149"
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- hl.EdgyTitle = {
  --   fg = c.blue,
  --   bg = c.bg_dark,
  -- }
  -- hl.EdgyIcon = {
  --   fg = c.blue,
  --   bg = c.bg_dark,
  -- }
  -- hl.EdgyIconActive = {
  --   fg = c.orange,
  --   bg = c.bg_dark,
  -- }
end

local opts = {
  -- For transparent background to take effect, the style name here must be same as that
  -- applied to current terminal app (e.g. in kitty.conf)
  style = "moon",

  styles = {
    sidebars = "transparent",
    floats = "dark",
  },

  on_highlights = function(hl, c)
    borderless_telescope(hl, c)
  end,
}

return {
  "folke/tokyonight.nvim",
  opts = opts,
}
