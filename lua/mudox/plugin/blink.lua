local opts = {
  enabled = function()
    return vim.bo.buftype ~= "prompt" and vim.b.mdx_blink ~= false
  end,

  completion = {
    menu = {
      auto_show = function(ctx)
        -- Don't show completion menu automatically when searching
        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
      end,
      draw = {
        columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
        components = {
          item_idx = {
            text = function(ctx)
              return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
            end,
            highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
          },
        },
      },
    },
  },

  -- stylua: ignore
  keymap = {
    preset = "default",
    ["<C-1>"] = { function(cmp) cmp.accept { index = 1 } end },
    ["<C-2>"] = { function(cmp) cmp.accept { index = 2 } end },
    ["<C-3>"] = { function(cmp) cmp.accept { index = 3 } end },
    ["<C-4>"] = { function(cmp) cmp.accept { index = 4 } end },
    ["<C-5>"] = { function(cmp) cmp.accept { index = 5 } end },
    ["<C-6>"] = { function(cmp) cmp.accept { index = 6 } end },
    ["<C-7>"] = { function(cmp) cmp.accept { index = 7 } end },
    ["<C-8>"] = { function(cmp) cmp.accept { index = 8 } end },
    ["<C-9>"] = { function(cmp) cmp.accept { index = 9 } end },
  },
}

return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  opts = opts,
  cond = C.blink,
}
