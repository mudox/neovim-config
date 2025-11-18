local opts = {
  enabled = true,
  preset = {
    header = U.logo(),
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find",     action  = ":lua Snacks.dashboard.pick('files')"     },
          { icon = " ", key = "r", desc = "Recent",   action  = ":lua Snacks.dashboard.pick('oldfiles')"  },
          { icon = " ", key = "q", desc = "New",      action  = ":ene | startinsert"                      },
          { icon = "󰦪 ", key = "g", desc = "Grep",     action  = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰞷 ", key = "t", desc = "Terminal", action  = ":Xpress"                                 },
          { icon = "󰭹 ", key = "R", desc = "Restore",  section = "session"                                 },
          { icon = " ", key = "v", desc = "Plugin",   action  = ":Lazy"                                   },
        },
  },
}

return {
  opts = opts,
}
