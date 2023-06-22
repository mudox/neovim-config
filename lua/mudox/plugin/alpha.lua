return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  keys = {
    { "<Space>a", "<Cmd>Alpha<Cr>", desc = "Alpha Dashboard" },
  },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
  ███╗   ███╗ ██╗   ██╗ ██████╗   ██████╗  ██╗  ██╗
  ████╗ ████║ ██║   ██║ ██╔══██╗ ██╔═══██╗ ╚██╗██╔╝  
  ██╔████╔██║ ██║   ██║ ██║  ██║ ██║   ██║  ╚███╔╝ 
  ██║╚██╔╝██║ ██║   ██║ ██║  ██║ ██║   ██║  ██╔██╗ 
  ██║ ╚═╝ ██║ ╚██████╔╝ ██████╔╝ ╚██████╔╝ ██╔╝ ██╗
  ╚═╝     ╚═╝  ╚═════╝  ╚═════╝   ╚═════╝  ╚═╝  ╚═╝
  ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <Cr>"),
      dashboard.button("n", " " .. " New file", ":ene <Bar> startinsert <Cr>"),
      dashboard.button("g", "󱉶 " .. " Find text", ":Telescope live_grep <Cr>"),
      dashboard.button("s", "󰦛 " .. " Restore Session", [[:lua require("persistence").load() <Cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<Cr>"),
      dashboard.button("m", "󰈏 " .. " Mason", ":Mason<Cr>"),
      dashboard.button("c", " " .. " ChatGPT", ":ChatGPT<Cr>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <Cr>"),
      dashboard.button("q", " " .. " Quit", ":qa<Cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
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
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
