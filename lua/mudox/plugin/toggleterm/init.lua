local function t(name)
  return require("mudox.plugin.toggleterm." .. name)
end

local opts = {
  open_mapping = "<C-t>",

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
    border = I.border.box,
    winblend = 0, -- transparency makes double width symbol display incorrectly
  },

  -- dropbar provides winbar for both toggleterm and builtin term
  -- winbar = { enabled = false },
}

local function config()
  require("toggleterm").setup(opts)
  t("git"):init()
end

local function move(direction)
  return function()
    t("util").move(direction)
  end
end

local function toggle_gitui()
  t("git").gitui:toggle()
end

local function toggle_lazygit()
  t("git").lazygit:toggle()
end

local function change_layout()
  t("util").change_layout()
end

-- stylua: ignore
local keys = {
  { "<C-t>", desc = "[ToggleTerm] toggle" },

  -- layout
  { "<C-\\>s",      move("horizontal"),           desc = "[ToggleTerm] Move to bottom",      mode = { "n", "t" } },
  { "<C-\\>v",      move("vertical"),             desc = "[ToggleTerm] Move to right",       mode = { "n", "t" } },
  { "<C-\\>t",      move("tab"),                  desc = "[ToggleTerm] Move to new tabpage", mode = { "n", "t" } },
  { "<C-\\>f",      move("float"),                desc = "[ToggleTerm] Move to float",       mode = { "n", "t" } },
  { "<C-\\><C-\\>", change_layout,                desc = "[ToggleTerm] Change layout",       mode = { "n", "t" } },
  -- rename
  { "<C-\\>r",      "<Cmd>ToggleTermSetName<Cr>", desc = "[ToggleTerm] Rename"               },
  -- switch
  { "<C-\\><Tab>",  "<Cmd>TermSelect<Cr>",        desc = "[ToggleTerm] Select terminal"      },
  -- select terminal
  { "<leader>tx",   "<Cmd>TermSelect<Cr>",        desc = "Terminals"                         },
  { "<leader>wt",   "<Cmd>TermSelect<Cr>",        desc = "[ToggleTerm] Select terminal"      },
  -- prefer to use tmux popup when in tmux
  -- { "<leader>gl",   toggle_lazygit,               desc = "[ToggleTerm] LazyGit"              },
  -- { "<leader>gg",   toggle_gitui,                 desc = "[ToggleTerm] GitUI"                },
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
  -- config = true,
}
