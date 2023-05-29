local preset_toggleterm = {
  filetypes = { "toggleterm" },
  config = {
    width = 0.8,
    height = 0.7,
  },
}

local preset_dap_panes = {
  filetypes = { "dapui_.*", "dap-repl" },
  config = {
    top = 0.25,
    left = 0.6,
    width = 0.4,
    height = 0.65,
  },
  callbacks = {
    function()
      vim.wo.wrap = true
    end,
  },
}

local opts = {
  winopts = {
    offset = {
      width = 130,
      height = 0.85,
    },
    -- check :help nvim_open_win() for possible border values.
    border = "single",
  },

  exclude_filetypes = { "lspinfo", "mason", "lazy", "fzf", "qf" },

  presets = {
    preset_toggleterm,
    preset_dap_panes,
  },

  popup = {
    enabled = true,
    --   exclude_filetypes = {},
    --   exclude_buftypes = {},
  },
}

local function config(_, options)
  require("neo-zoom").setup(options)
  vim.keymap.set("n", "<CR>", function()
    vim.cmd("NeoZoomToggle")
  end, { silent = true, nowait = true })
end

return {
  "nyngwang/NeoZoom.lua",
  opts = opts,
  config = config,
  keys = {
    { "z<Space>", "<Cmd>NeoZoomToggle<Cr>", desc = "Neo Zoom" },
  },
}
