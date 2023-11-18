local function name_formatter(buf)
  -- buf contains:
  -- name                | str        | the basename of the active file
  -- path                | str        | the full path of the active file
  -- bufnr (buffer only) | int        | the number of the active buffer
  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`

  return vim.fn.fnamemodify(buf.name, ":t:r") -- remove file extension
end

local function opts()
  local o = {
    options = {
      separator_style = "thick",

      name_formatter = name_formatter,

      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },

      -- icons
      -- stylua: ignore start
      buffer_close_icon  = "󰅖",
      modified_icon      = "󰴓",
      close_icon         = "",
      left_trunc_marker  = "┄",
      right_trunc_marker = "┄",
      -- stylua: ignore end

      groups = {
        items = {
          require("bufferline.groups").builtin.pinned:with { icon = " " },
        },
      },
    },
  }

  return o
end

local function init()
  vim.o.termguicolors = true
  vim.o.mousemoveevent = true -- hover to show close icon
  vim.o.laststatus = 3

  if vim.fn.argc(-1) == 0 then
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaClosed",
      callback = function()
        require("bufferline")
      end,
    })
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        require("bufferline")
      end,
    })
  end
end

-- stylua: ignore
local keys = {
  { "<M-o>",   "Pick",                 "Pick",           k =  "l" },

  { "x",       "PickClose",            "Pick & close",   },
  { "<",       "CloseLeft",            "Close left",     },
  { ">",       "CloseRight",           "Close right",    },
  { ".",       "CloseOthers",          "Close other",    },
  { ";",       "GroupClose ungrouped", "Close unpinned", },

  { "-",       "TogglePin",            "Pin",            },

  { "L",       "CycleNext",            "Cycle next",     k =  "l" },
  { "H",       "CyclePrev",            "Cycle previous", k =  "l" },
}

keys = K.lazy_keys(keys, {
  key_prefix = "<leader>b",
  cmd_prefix = "BufferLine",
  desc_prefix = "BufferLine",
})

-- <leader>1~9 to switch to visually displayed buffer on buffer line
for i = 1, 9 do
  table.insert(keys, { "[" .. i, ("<Cmd>BufferLineGoToBuffer %d<Cr>"):format(i), desc = "[BufferLine] Buffer " .. i })
end

table.insert(keys, { "[$", "<Cmd>BufferLineGoToBuffer -1<Cr>", desc = "[BufferLine] Last buffer" })

return {
  "akinsho/bufferline.nvim",
  -- event = "VeryLazy", -- loaded by `dashboard.nvim` as its dependency
  init = init,
  keys = keys,
  opts = opts,
}
