local function version()
  local first_line = vim.fn.execute("version"):match("([^\n]+)")
  return first_line:gsub("^NVIM%s*", "")
end

local function logo()
  -- ASCII generator: https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=mudox
  -- Use font `ANSI Shadow`
  local default = [[
  ███╗   ███╗ ██╗   ██╗ ██████╗   ██████╗  ██╗  ██╗
  ████╗ ████║ ██║   ██║ ██╔══██╗ ██╔═══██╗ ╚██╗██╔╝
  ██╔████╔██║ ██║   ██║ ██║  ██║ ██║   ██║  ╚███╔╝
  ██║╚██╔╝██║ ██║   ██║ ██║  ██║ ██║   ██║  ██╔██╗
  ██║ ╚═╝ ██║ ╚██████╔╝ ██████╔╝ ╚██████╔╝ ██╔╝ ██╗
  ╚═╝     ╚═╝  ╚═════╝  ╚═════╝   ╚═════╝  ╚═╝  ╚═╝
  ]]

  local filename = ".ascii-art.txt"
  local err, lines = pcall(vim.fn.readfile, filename)
  lines = err and lines or vim.split(default, "\n")

  -- version line
  local ver = version()
  local w1 = vim.fn.strwidth(lines[2])
  local w2 = vim.fn.strwidth(ver)
  local indent = vim.fn["repeat"](" ", math.floor((w1 - w2) / 2))
  table.insert(lines, "")
  table.insert(lines, indent .. ver)

  return lines
end

-- stylua: ignore
local items = {
  { "f",       " " .. " Smart open",      [[<Cmd>lua require"mudox.plugin.telescope.util".smart_open()<Cr>]] },
  { "n",       " " .. " New file",        [[<Cmd>ene <Bar> startinsert<Cr>]]                                 },

  { "s",       "󱉶 " .. " Find text",       [[<Cmd>Telescope live_grep<Cr>]]                                   },

  { "l",       "󰒲 " .. " Lazy",            [[<Cmd>Lazy<Cr>]]                                                  },
  { "m",       "󰈏 " .. " Mason",           [[<Cmd>Mason<Cr>]]                                                 },

  { "h",       "󰘥 " .. " Help",            [[<Cmd>Telescope help_tags<Cr>]]                                   },

  { "R",       "󰦛 " .. " Restore session", [[<Cmd>lua require("persistence").load()<Cr>]]                     },
}

local function dashboard()
  local db = require("alpha.themes.dashboard")

  -- top margin
  db.opts.layout[1].val = 8

  -- header
  db.section.header.val = logo()
  db.section.header.opts.hl = "AlphaHeader"

  -- menu
  db.section.buttons.val = vim.tbl_map(function(v)
    return db.button(unpack(v))
  end, items)

  for _, button in ipairs(db.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
    button.opts.width = 66
  end
  db.section.buttons.opts.hl = "AlphaButtons"

  -- footer
  db.section.footer.opts.hl = "Type"

  return db
end

local function config()
  -- close Lazy and re-open when the dashboard is ready
  -- if vim.o.filetype == "lazy" then
  --   vim.cmd.close()
  --   On("User", {
  --     pattern = "AlphaReady",
  --     callback = function()
  --       require("lazy").show()
  --     end,
  --   })
  -- end

  local db = dashboard()
  require("alpha").setup(db.config)

  On("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local startup_ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      db.section.footer.val = (" %d(%d)   󰚭 %.2fms"):format(stats.loaded, stats.count, startup_ms)
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return {
  "goolord/alpha-nvim",
  dependencies = "lualine.nvim", -- `lualine` needs to be loaded BEFORE `alpha`
  event = "VimEnter",
  config = config,
  -- cond = C.alpha,
  cond = false,
}
