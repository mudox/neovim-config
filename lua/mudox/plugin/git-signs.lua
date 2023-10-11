-- stylua: ignore start
local signs = {
  add          = { hl = "GitSignsAdd",    text = "┃", numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn"    },
  change       = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  delete       = { hl = "GitSignsDelete", text = "┃", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
  topdelete    = { hl = "GitSignsDelete", text = "┃", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
  changedelete = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
}
-- stylua: ignore end

local function on_attach(buffer)
  local gs = require("gitsigns")

  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  end

  -- stylua: ignore start
  map({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

  -- stage
  map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
  map("n", "<leader>gu", gs.undo_stage_hunk, "Unstage Hunk")
  map("n", "<leader>gD", gs.reset_hunk, "Reset Hunk (Discard Changes)")

  -- blame
  map("n", "<leader>gb", function() gs.blame_line { full = true } end, "Blame Line")

  -- diff
  -- use diffview.nvim instead
  map("n", "<leader>gv", gs.preview_hunk, "Preview Hunk")

  -- goto
  map("n", "]h", gs.next_hunk, "Next Hunk")
  map("n", "[h", gs.prev_hunk, "Previous Hunk")
  map("n", "]g", gs.next_hunk, "Next Hunk")
  map("n", "[g", gs.prev_hunk, "Previous Hunk")
  -- stylua: ignore end
end

local opts = {
  on_attach = on_attach,

  -- UI
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  signs = signs,
  sign_priority = -100, -- show on leftmost sign column

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

  yadm = {
    enable = false,
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
