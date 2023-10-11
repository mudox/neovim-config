local function borderless_telescope(hl, c)
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- prompt
  local prompt = "#2d3149"
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

  -- preview
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- results
  hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
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
