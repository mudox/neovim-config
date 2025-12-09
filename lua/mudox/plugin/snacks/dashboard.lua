local opts = {
  enabled = true,
  preset = {
    header = U.logo(),
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find",     action  = ":Telescope smart_open"                   },
          { icon = " ", key = "q", desc = "New",      action  = ":enew"                                   },
          { icon = "󰦪 ", key = "g", desc = "Grep",     action  = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰞷 ", key = "t", desc = "Terminal", action  = ":Xpress"                                 },
          { icon = "󰭹 ", key = "R", desc = "Restore",  section = "session"                                 },
          { icon = " ", key = "v", desc = "Lazy",     action  = ":Lazy"                                   },
          { icon = " ", key = "m", desc = "Mason",    action  = ":Mason"                                  },
        },
  },
}

return {
  init = function()
    On.user("SnacksDashboardUpdatePost", function()
      if vim.bo.filetype == "snacks_dashboard" then
        pcall(vim.keymap.del, "n", "<Cr>", { buffer = true })
      end
    end)
  end,
  opts = opts,
}
