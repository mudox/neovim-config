local toggle_key = "<C-t>"

local opts = {
  open_mapping = toggle_key,

  shade_terminals = false, -- disable for clear window separator line

  direction = "horizontal",

  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return math.max(78, vim.o.columns * 0.4)
    end
  end,

  start_in_insert = true,

  float_opts = {
    border = require("mudox.ui.icon").border.box,
    winblend = 0, -- transparency makes double width symbol display incorrectly
  },

  -- dropbar provides winbar for both toggleterm and builtin term
  -- winbar = { enabled = false },
}

local function config()
  require("toggleterm").setup(opts)
  require("mudox.plugin.toggle-term.git"):init()
end

local function move(direction)
  return function()
    require("mudox.plugin.toggle-term.util").move(direction)
  end
end

local function toggle_gitui()
  require("mudox.plugin.toggle-term.git").gitui:toggle()
end

local function toggle_lazygit()
  require("mudox.plugin.toggle-term.git").lazygit:toggle()
end

local function change_layout()
  require("mudox.plugin.toggle-term.util").change_layout()
end

-- stylua: ignore
local keys = {
  toggle_key,

  -- prefer to use tmux popup when in tmux
  { "<leader>gl", toggle_lazygit, desc = "LazyGit (ToggleTerm)", },
  { "<leader>gg", toggle_gitui, desc = "GitUI (ToggleTerm)", },

  -- layout
  { "<C-\\>s",      move("horizontal"), mode = { "n", "t" }, desc = "[ToggleTerm] Move to bottom" },
  { "<C-\\>v",      move("vertical"),   mode = { "n", "t" }, desc = "[ToggleTerm] Move to right" },
  { "<C-\\>t",      move("tab"),        mode = { "n", "t" }, desc = "[ToggleTerm] Move to new tabpage" },
  { "<C-\\>f",      move("float"),      mode = { "n", "t" }, desc = "[ToggleTerm] Move to float" },
  { "<C-\\><C-\\>", change_layout,      mode = { "n", "t" }, desc = "[ToggleTerm] Change layout" },

  -- rename
  { "<C-\\>r", "<Cmd>ToggleTermSetName<Cr>", mode = { "n", "t" }, desc = "[ToggleTerm] Rename" },

  -- select terminal
  { "<leader>wt",  "<Cmd>TermSelect<Cr>",                         desc = "[ToggleTerm] Select terminal" },
  { "<C-\\><Tab>", "<Cmd>TermSelect<Cr>",   mode = { "n", "t" },  desc = "[ToggleTerm] Select terminal" },
}

local cmd = {
  "ToggleTerm",
  "ToggleTermSendCurrentLine",
  "ToggleTermSendVisualLines",
  "ToggleTermSendVisualSelection",
  "ToggleTermSetName",
  "ToggleTermToggleAll",
}

return {
  "akinsho/toggleterm.nvim",
  cmd = cmd,
  keys = keys,
  config = config,
}
