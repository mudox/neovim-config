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
  local function nav(dir)
    return function()
      require("gitsigns").nav_hunk(dir, { foldopen = true, preview = true, wrap = true })
    end
  end

  -- stylua: ignore
  local op = {
    name = "gitsigns hunk",
    left  = nav("prev"),
    right = nav("next"),
  }

  local function blame()
    require("gitsigns").blame_line { full = true }
  end

  -- stylua: ignore
  return {
    -- stage
    { K.p"gs", function() require("gitsigns").stage_hunk() end,      desc = "stage hunk"      },
    { K.p"gD", function() require("gitsigns").reset_hunk() end,      desc = "discard changes" },

    -- blame
    { K.p"gb", blame,              desc = "blame line"      },

    -- view diff
    { K.p"gv", function() require("gitsigns").preview_hunk() end,    desc = "preview hunk"    },

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
    border = "none",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

return {
  "lewis6991/gitsigns.nvim",
  keys = keys,
  opts = opts,
}
