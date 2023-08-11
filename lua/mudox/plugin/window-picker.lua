local function goto()
  local id = require("window-picker").pick_window({
    -- hint = "floating-big-letter",
  })
  pcall(vim.api.nvim_set_current_win, id)
end

local keys = {
  { "<leader>ww", goto, desc = "[Window Picker] Goto window" },
}

local opts = {
  selection_chars = 'ASFGHJKLQWERUIOPZXCVNM',
  filter_rules = {
    include_current_win = true,
    bo = {
      filetype = {},
      buftype = {},
    }
  }
}

return {
  "s1n7ax/nvim-window-picker",
  keys = keys,
  opts = opts,
  config = function(_, o)
    require("window-picker").setup(o)
  end,
}
