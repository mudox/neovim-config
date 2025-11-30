local opts = {
  enabled = true,
  preset = {
    header = U.logo(),
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find",     action  = ":Telescope smart_open"                   },
          { icon = " ", key = "q", desc = "New",      action  = ":ene | startinsert"                      },
          { icon = "󰦪 ", key = "g", desc = "Grep",     action  = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰞷 ", key = "t", desc = "Terminal", action  = ":Xpress"                                 },
          { icon = "󰭹 ", key = "R", desc = "Restore",  section = "session"                                 },
          { icon = " ", key = "v", desc = "Lazy",     action  = ":Lazy"                                   },
          { icon = " ", key = "m", desc = "Mason",    action  = ":Mason"                                  },
        },
  },
}

return {
  opts = opts,
}
