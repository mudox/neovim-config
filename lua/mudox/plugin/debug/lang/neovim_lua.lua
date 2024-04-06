local adapter = {
  "jbyuki/one-small-step-for-vimkind",
  ft = "lua",
  dependencies = "nvim-dap",
}

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/nlua.lua
local function setup()
  local dap = require("dap")

  -- dap.configurations.lua = {
  --   {
  --     type = "nlua",
  --     request = "attach",
  --     name = "Attach to running Neovim instance",
  --   },
  -- }
  --
  -- dap.adapters.nlua = function(callback, config)
  --   callback {
  --     type = "server",
  --     host = config.host or "127.0.0.1",
  --     port = config.port or 8086,
  --   }
  -- end

  dap.adapters.nlua = function(callback, conf)
    local adapter = {
      type = "server",
      host = conf.host or "127.0.0.1",
      port = conf.port or 8086,
    }
    if conf.start_neovim then
      local dap_run = dap.run
      dap.run = function(c)
        adapter.port = c.port
        adapter.host = c.host
      end
      require("osv").run_this()
      dap.run = dap_run
    end
    callback(adapter)
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Run this file",
      start_neovim = {},
    },
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance (port = 8086)",
      port = 8086,
    },
  }

  -- dap.adapters.nlua = function(callback, config)
  --   callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
  -- end
  --
  -- dap.configurations.lua = {
  --   {
  --     type = "nlua",
  --     request = "attach",
  --     name = "Attach to running Neovim instance",
  --     program = function()
  --       pcall(require("osv").launch { port = 8086 })
  --     end,
  --   },
  -- }
end

return {
  adapter = adapter,
  setup = setup,
}
