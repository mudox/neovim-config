local toggle_key = "<C-t>"

local opts = {
  open_mapping = toggle_key,
  -- insert_mappings = false,

  shade_terminals = true,
  shading_factor = -20,

  direction = "float",
  -- direction = "horizontal",
  -- direction = "vertical",

  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return math.max(78, vim.o.columns * 0.4)
    end
  end,

  start_in_insert = true,

  float_opts = {
    -- border = "single",
    winblend = 0, -- transparency makes double width symbol display incorrectly
  },

  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end,
  },
}

local function config(_, options)
  require("toggleterm").setup(options)
  require("mudox.plugin.toggle-term.git"):init()
end

local function move(direction)
  return function()
    require("mudox.plugin.toggle-term.utils").move(direction)
  end
end

local function toggle_gitui()
  require("mudox.plugin.toggle-term.git").gitui:toggle()
end

local function toggle_lazygit()
  require("mudox.plugin.toggle-term.git").lazygit:toggle()
end

-- stylua: ignore start
local keys = {
  toggle_key,
  -- ISSUE: can not close after open using the keymap
  { "<leader>gl", toggle_lazygit, desc = "LazyGit (ToggleTerm)", },
  { "<leader>gg", toggle_gitui, desc = "GitUI (ToggleTerm)", },

  { "<C-\\><Space>", move("horizontal"), mode = { "n", "t" }, desc = "Move Terminal Window To Bottom" },
  { "<C-\\><C-\\>", move("vertical"), mode = { "n", "t" }, desc = "Move Terminal Window To Right" },
  { "<C-\\><Tab>", move("tab"), mode = { "n", "t" }, desc = "Move Terminal Window To New Tabpage" },
  { "<C-\\><Cr>", move("float"), mode = { "n", "t" }, desc = "Move Terminal Window To Float" },
}
-- stylua: ignore end

return {
  "akinsho/toggleterm.nvim",
  keys = keys,
  opts = opts,
  config = config,
}
