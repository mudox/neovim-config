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
          { icon = "󰭹 ", key = "R", desc = "Restore",  action  = ":lua require('persistence').load()"      },
          { icon = " ", key = "v", desc = "Lazy",     action  = ":Lazy"                                   },
          { icon = " ", key = "m", desc = "Mason",    action  = ":Mason"                                  },
        },
  },
}

return {
  init = function()
    On.User("SnacksDashboardUpdatePost", function()
      for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].filetype == "snacks_dashboard" then
          pcall(vim.keymap.del, "n", "<Cr>", { buffer = bufnr })
        end
      end
    end)
  end,
  opts = opts,
}
