local wvar = "mdx_float_term"

-- stylua: ignore
---param win number?
local function is_term_win(win)
  return pcall(vim.api.nvim_win_get_var, win or 0, wvar)
end

local function get_title(name)
  if name:match("^term://") then
    local cmd = name:match(":([^:]+)$")
    if cmd then
      cmd = vim.fn.fnamemodify(cmd, ":t")
      return cmd
    else
      return "term"
    end
  else
    return name
  end
end

local function get_term_bufnrs()
  return vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(bufnr)
      return vim.bo[bufnr].buftype == "terminal"
    end)
    :totable()
end

local function update_winbar()
  if not is_term_win() then
    return
  end

  local bufnrs = get_term_bufnrs()
  assert(#bufnrs > 0)

  local current_bufnr = vim.api.nvim_get_current_buf()

  local parts = vim
    .iter(bufnrs)
    :map(function(bufnr)
      local title = get_title(vim.api.nvim_buf_get_name(bufnr))
      local group1 = bufnr == current_bufnr and "_term_winbar_item_selected" or "_term_winbar_item"
      local group2 = bufnr == current_bufnr and "_term_winbar_item_selected_reverted" or "_term_winbar_item_reverted"
      local r, l = ("%%#%s#"):format(group2), ("%%#%s#"):format(group2)
      return r .. ("%%#%s#  %s  "):format(group1, title) .. l
    end)
    :totable()

  vim.wo.winbar = table.concat(parts, "%#WinBar# ") .. "%#WinBar#"
end

local bufname = "term://:scratch"

---@return number?
local function get_term_win()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if is_term_win(win) then
      return win
    end
  end
end

local function open()
  assert(not is_term_win())

  -- if alreay open, jump to
  local win = get_term_win()
  if win then
    vim.api.nvim_set_current_win(win)
    return
  end

  local buf = nil
  local newbuf = false

  -- search for existing terminal buffer
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == "terminal" then
      buf = bufnr
      break
    end
  end

  -- no found, create a new buffer
  if buf == nil then
    newbuf = true
    buf = vim.api.nvim_create_buf(false, true) -- nolisted scratch
  end

  -- create window
  local total_lines = vim.o.lines
  local total_cols = vim.o.columns

  local height = math.max(10, math.floor(total_lines / 3))

  local margin = 4
  local width = total_cols - margin * 2 - 3

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    anchor = "SW",
    row = total_lines - 5,
    col = margin,
    zindex = 500,

    style = "minimal",
    border = "single",
  }
  win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.wo[win].winhl = "NormalFloat:_B,FloatBorder:_BBorder,WinBar:_B"
  vim.api.nvim_win_set_var(win, wvar, 1)

  if newbuf then
    vim.fn.termopen("zsh")
    vim.api.nvim_buf_set_name(buf, bufname)
    vim.bo[buf].swapfile = false
  end

  update_winbar()

  vim.cmd.startinsert { bang = true }
end

local function close()
  local win = get_term_win()
  if win then
    vim.api.nvim_win_close(win, true)
  end
end

local function toggle()
  if is_term_win() then
    close()
  else
    open()
  end
end

---@param dir "next" | "prev"
local function nav(dir)
  assert(is_term_win())

  local bufs = get_term_bufnrs()
  assert(bufs and #bufs > 0)

  local cur = vim.api.nvim_get_current_buf()
  for i = 1, #bufs do
    if bufs[i] == cur then
      local offset = (dir == "next" and 1 or -1) * vim.v.count1
      local n = (i - 1 + offset) % #bufs + 1
      vim.api.nvim_set_current_buf(bufs[n])
      return
    end
  end
end

local function delete()
  assert(is_term_win())
  local bufs = get_term_bufnrs()

  if #bufs == 1 then
    vim.api.nvim_buf_delete(0, { force = true })
  else
    local buf = vim.api.nvim_get_current_buf()
    nav("prev")
    vim.api.nvim_buf_delete(buf, { force = true })
    update_winbar()
  end
end

-- stylua: ignore
local function setup_global_keymaps()
  require("which-key").add {
    {
      mode = { "n", "t", "i", "v" },
      { "<C-S-j>", toggle, desc = "[Term] Toggle" },
    },
    {
      mode = 't',
      { "<C-S-]>",  function() nav("next") end, desc = "[Term] Next"    },
      { "<C-S-[>",  function() nav("prev") end, desc = "[Term] Prev"    },

      { "<C-S-Cr>", K.c'terminal',              desc = "[Term] New"     },
      { "<C-S-±>",  delete,                     desc = "[Term] Delete"  },
    }
  }
end

-- stylua: ignore
local function setup_buffer_keymaps()
  require('which-key').add {
    mode = 'n', buffer = true,
    {
      { "<C-S-]>",  function() nav("next") end, desc = "[Term] Next"    },
      { "<C-S-[>",  function() nav("prev") end, desc = "[Term] Prev"    },

      { "<C-S-Cr>", K.c'terminal',              desc = "[Term] New"     },
      { "<C-S-±>",  delete,                     desc = "[Term] Delete"  },
    }
  }
end

local function preceate()
  vim.cmd("tabnew")

  vim.cmd.terminal("zsh")
  setup_buffer_keymaps()
  vim.bo.buflisted = false
  vim.bo.swapfile = false

  vim.cmd.tabclose()
end

On("TermOpen", function()
  vim.bo.buflisted = false
  update_winbar()
  setup_buffer_keymaps()
end)

On("BufEnter", update_winbar)

On("WinEnter", function()
  if not is_term_win() then
    close()
  end
end)

setup_global_keymaps()
-- after autcmds setup
preceate()

return {
  close = close,
}
