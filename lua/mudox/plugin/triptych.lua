local function config()
  local opts = {
    options = {
      file_icons = {
        enabled = true,
      },

      line_numbers = {
        enabled = false,
      },

      backdrop = 100,
      transparency = 0,
    },

    git_signs = {
      enabled = false,
    },

    diagnostic_signs = {
      enabled = false,
    },
  }

  require("triptych").setup(opts)

  -- HACK: change winhighlight
  X.swizzle_nvim_open_win:add_handler(function(ctx, orig, args)
    local plugin = false
    local fn = false
    local hit = vim.tbl_contains(ctx, function(v)
      if v.plugin == "triptych.nvim" then
        plugin = true
      end
      if v.fn == "create_floating_window" then
        fn = true
      end
      return plugin and fn
    end, { predicate = true })

    if hit then
      local winid = orig(unpack(args))
      vim.wo[winid].winhighlight = "NormalFloat:mdx_f,FloatBorder:mdx_fb"
      return winid
    else
      return false
    end
  end)
end

return {
  "simonmclean/triptych.nvim",
  dependencies = {
    "plenary.nvim",
    "mini.nvim",
    "antosha417/nvim-lsp-file-operations", -- optional LSP integration
  },
  keys = {
    { K.p("ot"), "<Cmd>Triptych<Cr>", desc = "[triptych] toggle" },
  },
  config = config,
}
