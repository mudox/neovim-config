local function name_formatter(buf)
  -- buf contains:
  -- name                | str        | the basename of the active file
  -- path                | str        | the full path of the active file
  -- bufnr (buffer only) | int        | the number of the active buffer
  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`

  return vim.fn.fnamemodify(buf.name, ":t:r")
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
    },
  }

  -- stylua: ignore start
  local icons = {
    buffer_close_icon  = "󰅖 ",
    modified_icon      = "󰴓 ",
    close_icon         = " ",
    left_trunc_marker  = " ",
    right_trunc_marker = " ",
  }
  for i = 1, #icons do
    icons[i] = icons[i]:sub(1, 1)
  end
  -- stylua: ignore end
  vim.list_extend(o, icons)

  return o
end

local function init()
  vim.o.termguicolors = true
  vim.o.mousemoveevent = true -- hover to show close icon
  vim.o.laststatus = 3

  local gid = vim.api.nvim_create_augroup("mudox_load_buffer_line", { clear = true })
  if vim.fn.argc(-1) == 0 then
    vim.api.nvim_create_autocmd("User", {
      group = gid,
      pattern = "AlphaClosed",
      desc = "Load bufferline.nvim after Alpha closed",
      callback = function()
        require("bufferline")
      end,
    })
  else
    vim.api.nvim_create_autocmd("VeryLazy", {
      group = gid,
      desc = "Load bufferline.nvim on 1st buffer load",
      callback = function()
        require("bufferline")
      end,
    })
  end
end

return {
  "akinsho/bufferline.nvim",
  init = init,
  opts = opts,
}
