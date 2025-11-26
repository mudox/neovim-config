local a = require("telescope.actions")
local ma = require("mudox.plugin.telescope.keymaps.actions")

local function open_with_trouble(...)
  require("trouble.sources.telescope").open(...)
end

local function add_to_trouble(...)
  require("trouble.sources.telescope").add(...)
end

-- stylua: ignore
local insert = {
  -- disable normal mode
  -- ["<Esc>"]     = a.close,

  -- restore nvim default
  ["<C-u>"]     = false,

  -- preview
  ["?"]         = require("telescope.actions.layout").toggle_preview,

  -- scroll preview
  ["<C-f>"]     = a.preview_scrolling_down,
  ["<C-b>"]     = a.preview_scrolling_up,

  -- scroll results
  ["<Down>"]    = a.results_scrolling_down,
  ["<Up>"]      = a.results_scrolling_up,

  -- send to trouble
  ["<C-x>"]     = open_with_trouble,
  ["<C-a>"]     = add_to_trouble,

  -- history
  ["<C-j>"]     = a.cycle_history_next,
  ["<C-k>"]     = a.cycle_history_prev,

  ["<C-/>"]     = a.which_key,

  -- flash labels
  ["<C-d>"]     = ma.flash,

  -- inspect
  ["<C-Right>"] = ma.inspect + a.close,

  -- open
  -- <Cr> open in current window
  -- <C-s> open below
  -- <C-v> open to right
  -- <C-t> open in new tabpage
  ["<C-s>"]     = a.select_horizontal,
  ["<M-h>"]     = ma.open_in_main,
  ["<C-Cr>"]    = ma.open_in_main,
  ["<M-l>"]     = ma.open_in_secondary,
  ["<C-v>"]     = ma.open_in_secondary,
  ["<C-S-Cr>"]  = ma.open_in_secondary,
}

local normal = {
  ["q"] = function(...)
    return a().close(...)
  end,
}

return { i = insert, n = normal }
