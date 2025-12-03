local cmdline = {
  enabled = true,

  sources = function()
    local type = vim.fn.getcmdtype()
    if type == "/" or type == "?" then
      return { "buffer" }
    end
    if type == ":" or type == "@" then
      return { "cmdline" }
    end
    return {}
  end,

  completion = {
    menu = { auto_show = true },

    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },

  keymap = { preset = "inherit" },
}

-- stylua: ignore
local keymap = {
  preset = "enter",

  ["<C-y>"]     = {}, -- conflict with tmux

  -- tab
  ["<Tab>"]     = { "select_and_accept", "fallback" },
  ["<S-Tab>"]   = {},

  -- nav
  ["<C-p>"]     = { "select_prev", "fallback" },
  ["<C-n>"]     = { "select_next", "fallback" },

  -- scroll documentation
  ["<C-f>"]     = {}, -- conflict with LuaSnip
  ["<C-b>"]     = {},
  ["<C-u>"]     = { "scroll_documentation_up", "fallback" },
  ["<C-d>"]     = { "scroll_documentation_down", "fallback" },

  -- accept
  ["<C-Enter>"] = { "select_and_accept" },
  ["<C-1>"]     = { function(cmp) cmp.accept { index = 1 } end, },
  ["<C-2>"]     = { function(cmp) cmp.accept { index = 2 } end, },
  ["<C-3>"]     = { function(cmp) cmp.accept { index = 3 } end, },
  ["<C-4>"]     = { function(cmp) cmp.accept { index = 4 } end, },
  ["<C-5>"]     = { function(cmp) cmp.accept { index = 5 } end, },
}

local sources = {
  default = { "lazydev", "lsp", "path", "snippets", "buffer" },

  providers = {
    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      score_offset = 100,
    },
    path = {
      opts = {
        get_cwd = function(_)
          return vim.fn.getcwd()
        end,
      },
    },
    buffer = {
      opts = {
        get_bufnrs = function()
          return vim.tbl_filter(function(bufnr)
            return vim.bo[bufnr].buftype == ""
          end, vim.api.nvim_list_bufs())
        end,
      },
    },
    snippets = {
      should_show_items = function(ctx)
        return ctx.trigger.initial_kind ~= "trigger_character"
      end,
    },
  },
}

local completion = {
  list = {
    selection = {
      preselect = false,
      auto_insert = true,
    },
  },
  menu = {
    auto_show = function(ctx)
      -- Don't show completion menu automatically when searching
      return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
    end,
    draw = {
      columns = {
        { "kind_icon" },
        { "label", gap = 1 }, -- colorful-menu combines label & label_description
      },
      components = {
        kind_icon = {
          ellipsis = false,
          text = function(ctx)
            local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
            return icon .. " " -- gap
          end,
          highlight = function(ctx)
            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
            return hl
          end,
        },

        -- colorful-menu.nvim
        -- https://github.com/xzbdmw/colorful-menu.nvim?tab=readme-ov-file#use-it-in-blinkcmp
        label = {
          width = { fill = true, max = 60 },
          text = function(ctx)
            local highlights_info = require("colorful-menu").blink_highlights(ctx)
            if highlights_info ~= nil then
              -- Or you want to add more item to label
              return highlights_info.label
            else
              return ctx.label
            end
          end,
          highlight = function(ctx)
            local highlights = {}
            local highlights_info = require("colorful-menu").blink_highlights(ctx)
            if highlights_info ~= nil then
              highlights = highlights_info.highlights
            end
            for _, idx in ipairs(ctx.label_matched_indices) do
              table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
            end
            -- Do something else
            return highlights
          end,
        },
      },
    },
  },
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 800,
  },
}

local opts = {
  enabled = function()
    return vim.bo.buftype ~= "prompt" and vim.b.mdx_blink ~= false
  end,
  completion = completion,

  signature = { enabled = true },
  snippets = { preset = "luasnip" },

  sources = sources,
  keymap = keymap,
  cmdline = cmdline,
}

return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  opts = opts,
}
