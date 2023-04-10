local function setup_keymaps_and_formatting_on_attach()
  -- setup formatting and keymaps
  require("mudox.lib").on_attach(function(client, buffer)
    require("mudox.plugin.lsp.format").on_attach(client, buffer)
    require("mudox.plugin.lsp.keymaps").on_attach(client, buffer)
  end)
end

local function setup_signs()
  local i = require("mudox.ui").icons
  local signs = {
    { name = "DiagnosticSignError", text = i.error },
    { name = "DiagnosticSignWarn", text = i.warn },
    { name = "DiagnosticSignInfo", text = i.info },
    { name = "DiagnosticSignHint", text = i.hint },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end
end

local function setup_diagnostic()
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,

    sign = true,
    underline = true,
    virtual_text = { spacing = 4, prefix = "⏹" },

    -- float = {
    --   source = "always",
    -- },
  }
end

local function setup_servers()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local function setup(server_name)
    local res, server = pcall(require, "mudox.plugin.lsp.server." .. server_name)
    if not res then
      -- server = {}
      return
    end

    local opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, server.opts or {})

    if server.setup then
      if server.setup() then
        -- returning `true` skips `lspconfig.setup`
        return
      end
    end

    require("lspconfig")[server_name].setup(opts)
  end

  local mlc = require("mason-lspconfig")
  local available = mlc.get_available_servers()
  local install_by_mason = {}

  for name, type in vim.fs.dir("~/.config/nvim/lua/mudox/plugin/lsp/server") do
    if type == "file" and name:sub(-4) == ".lua" then
      local server_name = name:sub(1, -5)
      local server = require("mudox.plugin.lsp.server." .. server_name)

      if server.mason == false or not vim.tbl_contains(available, server) then
        setup(server_name)
      else
        install_by_mason[#install_by_mason + 1] = server_name
      end
    end
  end

  mlc.setup { ensure_installed = install_by_mason }
  mlc.setup_handlers { setup }
end

local function setup_mason() end

local dependencies = {
  { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  { "folke/neodev.nvim", config = false },

  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  "hrsh7th/cmp-nvim-lsp",
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = dependencies,
  config = function()
    require("neodev").setup {}

    setup_signs()
    setup_diagnostic()
    setup_keymaps_and_formatting_on_attach()
    setup_mason()
    setup_servers()
  end,
}
