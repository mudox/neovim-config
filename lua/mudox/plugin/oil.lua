local detail = false

local function config()
  local opts = {
    keymaps = {
      ["<C-s>"] = "actions.select_split",

      ["<C-v>"] = "actions.select_vsplit",
      ["<C-h>"] = false,

      ["<C-c>"] = false,
      ["q"] = "actions.close",

      ["<C-l>"] = false,
      ["<C-r>"] = "actions.refresh",

      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns { "icon", "permissions", "size", "mtime" }
          else
            require("oil").set_columns { "icon" }
          end
        end,
      },
    },

    win_options = {
      winbar = "%!v:lua.dropbar()",
    },

    keymaps_help = {
      border = "none",
    },
    float = {
      padding = 2,
      border = "single",
      max_width = 0.7,
      max_height = 0.8,
    },
    preview = {
      border = "none",
    },
    progress = {
      border = "none",
    },
    ssh = {
      border = "none",
    },

    watch_for_changes = true,
  }

  require("oil").setup(opts)

  On.FileType("oil", function()
    vim.wo.winhighlight = "NormalFloat:mdx_f,FloatBorder:mdx_fb"
  end)
end

return {
  "stevearc/oil.nvim",
  lazy = false, -- for default explorer
  -- stylua: ignore
  keys = {
    { "<M-o>", K.c"Oil",         desc = "[oil] open", },
    { K.p"oo", K.c"Oil",         desc = "[oil] open", },
    { K.p"oO", K.c"Oil --float", desc = "[oil] open float", },
  },
  cmd = "Oil",
  config = config,
}
