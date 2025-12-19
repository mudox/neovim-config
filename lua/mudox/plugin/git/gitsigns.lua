local bar = I.bar

-- stylua: ignore
local signs = {
  add          = {  text = bar },
  change       = {  text = bar },
  delete       = {  text = bar },
  topdelete    = {  text = bar },
  changedelete = {  text = bar },
  untracked    = {  text = bar },
}

local function keys()
  local gs = require("gitsigns")

  -- stylua: ignore
  local op = {
    name = "gitsigns hunk",
    left  = function() gs.nav_hunk("prev", { foldopen = true, preview = true, wrap = true }) end,
    right = function() gs.nav_hunk("next", { foldopen = true, preview = true, wrap = true }) end,
  }

  local function blame()
    gs.blame_line { full = true }
  end

  -- stylua: ignore
  return {
    -- stage
    { K.p"gs", gs.stage_hunk,      desc = "stage hunk"      },
    { K.p"gD", gs.reset_hunk,      desc = "discard changes" },

    -- blame
    { K.p"gb", blame,              desc = "blame line"      },

    -- diff
    { K.p"gv", gs.preview_hunk,    desc = "preview hunk"    },

    -- goto
    { "[c",    X.arrows.left(op),  desc = "diff hunk"       },
    { "]c",    X.arrows.right(op), desc = "diff hunk"       },
  }
end

local opts = {
  -- UI
  signcolumn = false, -- disabled initially, toggle with `:Gitsigns toggle_signs`
  signs = signs,

  numhl = false,
  linehl = false,

  -- Blame
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },

  update_debounce = 100,
  max_file_length = 40000,

  status_formatter = nil, -- Use default

  -- Preview
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  keys = keys,
  opts = opts,
  cond = false,
}
