return {
  "A7Lavinraj/fyler.nvim",
  cmd = "Fyler",
  -- stylua: ignore
  keys = {
    { K.p"of", K.c"Fyler",            desc = "[fyler] open"       },
    { K.p"oF", K.c"Fyler kind=float", desc = "[fyler] open float" },
  },
  opts = {
    views = {
      finder = {
        columns = {
          git = {
            enabled = false,
          },
        },
        mappings_opts = {
          nowait = true,
        },
        mappings = {
          ["<C-v>"] = "SelectVSplit",
          ["<C-s>"] = "SelectSplit",

          ["zm"] = "CollapseNode",
          ["zM"] = "CollapseAll",

          ["-"] = "GotoParent",
        },
        win = {
          kinds = {
            float = {
              win_opts = {
                winhighlight = "NormalFloat:mdx_f,FloatBorder:mdx_fb,FloatTitle:mdx_fb",
              },
            },
          },
        },
      },
    },
  },
}
