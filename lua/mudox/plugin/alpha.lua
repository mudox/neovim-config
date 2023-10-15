-- NOTE:
-- ASCII generator: https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=mudox
-- Use font `ANSI Shadow`

local function logo()
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

  return lines
end

local function opts()
  local db = require("alpha.themes.dashboard")

  -- Header
  db.section.header.val = logo()
  db.section.header.opts.hl = "AlphaHeader"

  -- Menu
  local b = db.button
  -- stylua: ignore start
  db.section.buttons.val = {
    b("o", " " .. " Open",            [[<Cmd>Telescope smart_open<Cr>]]),
    -- b("f", " " .. " Find file",       [[<Cmd>Telescope find_files<Cr>]]),
    -- b("R", " " .. " Recent files",    [[<Cmd>Telescope oldfiles <Cr>]]),
    b("n", " " .. " New file",        [[<Cmd>ene <Bar> startinsert<Cr>]]),

    b("s", "󱉶 " .. " Find text",       [[<Cmd>Telescope live_grep<Cr>]]),

    b("l", "󰒲 " .. " Lazy",            [[<Cmd>Lazy<Cr>]]),
    b("m", "󰈏 " .. " Mason",           [[<Cmd>Mason<Cr>]]),

    b("c", " " .. " ChatGPT",         [[<Cmd>ChatGPT<Cr>]]),
    b("t", " " .. " Terminal",        [[<Cmd>ToggleTerm<Cr>]]),

    b("r", "󰦛 " .. " Restore session", [[<Cmd>lua require("persistence").load()<Cr>]]),
    b("q", " " .. " Quit",            [[<Cmd>qa<Cr>]]),
  }
  -- stylua: ignore end

  for _, button in ipairs(db.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
    button.opts.width = 66
  end
  db.section.buttons.opts.hl = "AlphaButtons"

  -- Footer
  db.section.footer.opts.hl = "Type"

  db.opts.layout[1].val = 8

  return db
end

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  keys = {
    { "<Space>a", "<Cmd>Alpha<Cr>", desc = "Alpha Dashboard" },
  },
  opts = opts,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
