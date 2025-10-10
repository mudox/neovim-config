local function name_formatter(buf)
  -- buf contains:
  -- name                | str        | the basename of the active file
  -- path                | str        | the full path of the active file
  -- bufnr (buffer only) | int        | the number of the active buffer
  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`

  return vim.fn.fnamemodify(buf.name, ":t:r") -- remove file extension
end

local function filter(bufnr, bufnrs)
  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  return true
end

local function init()
  vim.o.termguicolors = true
  vim.o.mousemoveevent = true -- hover to show close icon
  vim.o.laststatus = 3

  On("WinEnter", function()
    if not U.window.is_floating() then
      local listed_buffers = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted
      end, vim.api.nvim_list_bufs())
      if #listed_buffers > 0 then
        require("bufferline")
      end
      return true
    else
      return false
    end
  end)

  if vim.fn.argc(-1) == 0 then
    On("User", {
      pattern = "AlphaClosed",
      callback = function()
        require("bufferline")
      end,
    })
  else
    On("User", {
      pattern = "VeryLazy",
      callback = function()
        require("bufferline")
      end,
    })
  end
end

local function opts()
  local o = {
    options = {
      indicator = { style = "none" },
      separator_style = { "", " " }, -- transparent tabline appearance

      name_formatter = name_formatter,

      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },

      -- icons
      -- stylua: ignore start
      buffer_close_icon  = "󰅖",
      modified_icon      = "•",
      close_icon         = "󰅖",
      left_trunc_marker  = "⋯",
      right_trunc_marker = "⋯",
      -- stylua: ignore end

      groups = {
        items = {
          require("bufferline.groups").builtin.pinned:with { icon = " " },
        },
      },

      custom_filter = filter,
    },
  }

  return o
end

-- stylua: ignore
local keys = {
  { "<M-,> ✓",      "Pick",                 "Pick",           },
  { K.p"fp ✓", "Pick",                 "Pick",           },

  -- close buffer
  { "x",            "PickClose",            "Pick & close",   },
  { "<",            "CloseLeft",            "Close left",     },
  { ">",            "CloseRight",           "Close right",    },
  { "o",            "CloseOthers",          "Close other",    },
  { "O",            "GroupClose ungrouped", "Close unpinned", },

  { "-",            "TogglePin",            "Pin",            },

  { "<C-S-]> ✓",    "CycleNext",            "Cycle next",     },
  { "<C-S-[> ✓",    "CyclePrev",            "Cycle previous", },
}
keys = K.lazy_keys(keys, {
  key_prefix = K.p"b",
  cmd_prefix = "BufferLine",
  desc_prefix = "BufferLine",
})

-- <leader>[1-5] to switch to visually displayed buffer on buffer line
for i = 1, 5 do
  table.insert(keys, { "[" .. i, ("<Cmd>BufferLineGoToBuffer %d<Cr>"):format(i), desc = "[BufferLine] Buffer " .. i })
end

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  cmd = { "BufferLineTabRename" },
  init = init,
  keys = keys,
  opts = opts,
}
