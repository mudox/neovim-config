-- stylua: ignore start
local keys = {
  {'<leader>we', function() require("edgy").select() end,    'Goto Edgy Window' },
  {'<leader>wm', function() require("edgy").goto_main() end, 'Goto Main Area' },
  {'<leader>wx', function() require("edgy").close() end, 'Close All Edgy Windows' },
}
-- stylua: ignore end

local function init()
  -- views can only be fully collapsed with the global statusline
  vim.opt.laststatus = 3
  -- Default splitting will cause your main splits to jump when opening an edgebar.
  -- To prevent this, set `splitkeep` to either `screen` or `topline`.
  vim.opt.splitkeep = "screen"
end

local left = {
  -- NvimTree filesystem always takes half the screen height
  {
    title = "Files",
    ft = "NvimTree",
    size = { height = 0.5 },
  },
  {
    title = "Outline",
    ft = "aerial",
    pinned = true,
    open = "AerialOpen",
  },
}

local bottom = {
  -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
  "Trouble",
  {
    title = "QuickFix / LocList",
    ft = "qf",
    size = { height = 0.3 },
  },
  {
    title = "Help",
    ft = "help",
    size = { height = 0.3 },
    -- only show help buffers
    filter = function(buf)
      return vim.bo[buf].buftype == "help"
    end,
  },
}

local right = {
  {
    title = "Search & Replace",
    ft = "spectre_panel",
    size = { width = 0.4 },
  },
}

-- stylua: ignore start
local opts  = {
  left      = left,
  right     = right,
  bottom    = bottom,

  icons     = {
    closed  = "",
    open    = "",
  },
  animate   = {
    enabled = false,
  },
}
-- stylua: ignore end

return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  keys = keys,
  init = init,
  opts = opts,
}
