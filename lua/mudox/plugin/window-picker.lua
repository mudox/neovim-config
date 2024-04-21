local function pick()
  local id = require("window-picker").pick_window {
    -- hint = "floating-big-letter",
  }
  pcall(vim.api.nvim_set_current_win, id)
end

local keys = {
  { "<leader>ww", pick, desc = "[Window Picker] Goto window" },
}

local opts = {
  -- hint = "floating-big-letter",
  picker_config = {
    statusline_winbar_picker = {
      -- use_winbar = "always",
      -- selection_display = function(char, windowid)
      --   return "%=" .. char .. "%="
      -- end,
    },
  },
  selection_chars = "ASFGHJKLQWERUIOPZXCVNM",
  filter_func = function()
    return vim.tbl_keys(require("edgy.editor").list_wins().main)
  end,
}

return {
  "s1n7ax/nvim-window-picker",
  keys = keys,
  opts = opts,
}
