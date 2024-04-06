local bar = "┃"
-- local bar = "▕"

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
  local keys = {
    ["ih"]         = { "<Cmd>Gitsigns select_hunk<CR>",              "GitSigns Select Hunk", mode = { "x", "o" } },

    -- stage
    ["<leader>gs"] = { gs.stage_hunk,                                "Stage Hunk"                                },
    ["<leader>gu"] = { gs.undo_stage_hunk,                           "Unstage Hunk"                              },
    ["<leader>gD"] = { gs.reset_hunk,                                "Reset Hunk (Discard Changes)"              },

    -- blame
    ["<leader>gb"] = { function() gs.blame_line { full = true } end, "Blame Line"                                },

    -- diff
    ["<leader>gv"] = { gs.preview_hunk,                              "Preview Hunk"                              },

    -- goto
    ["󰅂g"]         = { gs.next_hunk,                                 "Next Hunk"                                 },
    ["󰅁g"]         = { gs.prev_hunk,                                 "Previous Hunk"                             },
  }

  require("which-key").register(keys, { buffer = buffer })
end

local opts = {
  on_attach = on_attach,

  -- UI
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
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
  current_line_blame_formatter_opts = {
    relative_time = true,
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
  event = { "BufRead", "BufNewFile" },
  opts = opts,
  keys = {
    { "<leader>g<Space>", "<Cmd>Gitsigns toggle_signs<Cr>", desc = "[GitSigns] Toggle signs" },
  },
}
