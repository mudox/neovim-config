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

local function on_attach(buffer)
  local gs = require("gitsigns")

  -- stylua: ignore
  local jump = {
    name = "Gitsigns hunk",
    next = function() gs.nav_hunk("next") end,
    prev = function() gs.nav_hunk("prev") end,
  }

  -- stylua: ignore
  local keys = {
    buffer = buffer,

    -- stage
    { "<leader>gs", gs.stage_hunk,                                desc = "Stage hunk"      },
    { "<leader>gD", gs.reset_hunk,                                desc = "Discard changes" },

    -- blame
    { "<leader>gb", function() gs.blame_line { full = true } end, desc = "Blame line"      },

    -- diff
    { "<leader>gv", gs.preview_hunk,                              desc = "Preview hunk"    },

    -- goto
    { "]c",         X.dirop.wrap(jump, "next"),                   desc = "Next hunk"       },
    { "[c",         X.dirop.wrap(jump, "prev"),                   desc = "Prev hunk"       },
  }

  require("which-key").add(keys)
end

local opts = {
  on_attach = on_attach,

  -- UI
  signcolumn = false, -- disabled initially, toggle with `:Gitsigns toggle_signs`
  signs = signs,

  numhl = true,
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
    border = I.border.box,
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = opts,
}
