local function logo()
  -- ASCII generator: https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=mudox
  -- font `ANSI Shadow`

  local default = [[
  ███╗   ███╗ ██╗   ██╗ ██████╗   ██████╗  ██╗  ██╗
  ████╗ ████║ ██║   ██║ ██╔══██╗ ██╔═══██╗ ╚██╗██╔╝
  ██╔████╔██║ ██║   ██║ ██║  ██║ ██║   ██║  ╚███╔╝
  ██║╚██╔╝██║ ██║   ██║ ██║  ██║ ██║   ██║  ██╔██╗
  ██║ ╚═╝ ██║ ╚██████╔╝ ██████╔╝ ╚██████╔╝ ██╔╝ ██╗
  ╚═╝     ╚═╝  ╚═════╝  ╚═════╝   ╚═════╝  ╚═╝  ╚═╝
  ]]

  local filename = ".ascii-art.txt"
  local ok, lines = pcall(vim.fn.readfile, filename)
  lines = ok and table.concat(lines, "\n") or default
  lines = ("\n"):rep(8) .. lines .. ("\n"):rep(4)

  return vim.split(lines, "\n")
end

local function pad(str, width)
  local str_width = vim.fn.strwidth(str)
  if str_width >= width then
    return str
  else
    local padding = width - str_width
    return str .. (" "):rep(padding)
  end
end

local function i(def)
  local icon, desc, key, action = unpack(def)
  return {
    icon = pad(icon, 3),
    desc = pad(desc, 57),
    key = key,
    action = action,
  }
end

-- stylua: ignore
local items = {
  i { " ", "Open",            "o", [[Telescope smart_open]] },
  i { " ", "New file",        "n", [[ene | startinsert]] },
  i { "󱉶 ", "Find text",       "s", [[Telescope live_grep]] },
  i { "󰒲 ", "Lazy",            "l", [[Lazy]] },
  i { "󰈏 ", "Mason",           "m", [[Mason]] },
  i { " ", "ChatGPT",         "c", [[ChatGPT]] },
  i { " ", "Terminal",        "t", [[ToggleTerm]] },
  i { "󰦛 ", "Restore session", "r", [[lua require("persistence").load()]] },
  i { " ", "Quit",            "q", [[qa]] },
}

local content = {
  header = logo(),
  center = items,
  disable_move = true,
}

local function config()
  require("dashboard").setup {
    theme = "doom",
    config = content,
  }
end

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  cmd = { "Dashboard", "DbProjectDelete" },
  keys = { { "<leader>vd", "<Cmd>Dashboard<Cr>", desc = "Dashboard" } },
  config = config,
  dependencies = {
    "nvim-web-devicons",

    -- make sure `bufferline`, `lualine` is loaded BEFORE dashboard
    "bufferline.nvim",
    "lualine.nvim",
  },
  cond = false, -- `alpha.nvim` is newer
}
