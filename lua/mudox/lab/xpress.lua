--- b:mdx_term_title
--- w:mdx_float_term

local M = {}

---@alias mdx.xpress.WinPos
---| '"float-bottom"'
---| '"float-top"'
---| '"float-right"'
---| '"float-left"'
---| '"float-center"'
---| '"split-bottom"'
---| '"split-top"'
---| '"split-right"'
---| '"split-left"'
---| '"split-left"'
---| '"tab"'

---@type mdx.xpress.WinPos
M.pos = "float-bottom"

M.margin = 4

---reposition terminal win
---@param pos mdx.xpress.WinPos?
function M.repos(pos)
  M.pos = pos or M.pos

  local win = M.get_term_win()
  if win then
    vim.api.nvim_win_set_config(win, M.calc_layout())
  else
    M.open()
  end
end

local log = Log("xpress")

local win_flag_varname = "mdx_float_term"
local title_varname = "mdx_term_title"

function M.calc_layout()
  local total_lines = vim.o.lines
  local total_cols = vim.o.columns

  if M.pos == "float-bottom" then
    local height = math.max(10, math.floor(total_lines / 3))
    local width = total_cols - M.margin * 2 - 3
    return {
      relative = "editor",
      anchor = "SW",
      row = total_lines - M.margin - 1,
      col = M.margin,
      width = width,
      height = height,
    }
  elseif M.pos == "float-top" then
    local height = math.max(10, math.floor(total_lines / 3))
    local width = total_cols - M.margin * 2 - 3
    return {
      relative = "editor",
      anchor = "NW",
      row = M.margin,
      col = M.margin,
      width = width,
      height = height,
    }
  elseif M.pos == "float-right" then
    local width = math.max(86, math.floor(total_cols / 3))
    local height = total_lines - M.margin * 2 - 3
    return {
      relative = "editor",
      anchor = "NE",
      row = M.margin,
      col = total_cols - M.margin - 1,
      width = width,
      height = height,
    }
  elseif M.pos == "float-left" then
    local width = math.max(86, math.floor(total_cols / 3))
    local height = total_lines - M.margin * 2 - 3
    return {
      relative = "editor",
      anchor = "NW",
      row = M.margin,
      col = M.margin,
      width = width,
      height = height,
    }
  elseif M.pos == "float-center" then
    local width = total_cols - M.margin * 4
    local height = total_lines - M.margin * 2 - 3
    return {
      relative = "editor",
      anchor = "NW",
      row = M.margin,
      col = M.margin * 2,
      width = width,
      height = height,
    }
  end
end

function M.new()
  assert(M.is_term_buf(0), "should be in term buffer")
  vim.cmd.terminal()
end

function M.rename()
  assert(M.is_term_buf(0), "should be in term buffer")

  local buf = vim.api.nvim_get_current_buf()
  vim.ui.input({ prompt = "New Name: " }, function(name)
    if name and name ~= "" then
      vim.api.nvim_buf_set_var(buf, title_varname, name)
      vim.cmd.redrawstatus { bang = true }
    end
  end)
end

function M.setup_term_buffer()
  vim.wo.winbar = ("%%!v:lua.mdx_term_winbar_render(%d)"):format(vim.api.nvim_get_current_win())
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  M.setup_local_keymaps()

  if M.is_floating_term_win(0) then
    vim.wo.winhl = "NormalFloat:mdx_block_float,FloatBorder:mdx_block_float_border,WinBar:mdx_float_term_winbar"
  else
    vim.wo.winhl = "WinBar:mdx_term_winbar"
  end
end

function M.is_floating_term_win(win)
  return pcall(vim.api.nvim_win_get_var, win, win_flag_varname)
end

function M.is_term_buf(buf)
  -- fzf would set its terminal buf's `ft` option
  return vim.bo[buf].buftype == "terminal" and vim.bo[buf].ft == ""
end

function M.get_title(buf)
  assert(M.is_term_buf(buf))

  local ok, title = pcall(vim.api.nvim_buf_get_var, buf, title_varname)
  if ok then
    assert(title and title ~= "")
    return title
  end

  local bufname = vim.api.nvim_buf_get_name(buf)
  assert(bufname:match("^term://"))
  local cmd = bufname:match("([^:/\\]+)$") -- remove term://{path}//pid:{bin_path}
  assert(cmd and cmd ~= "")
  local bin = cmd:match("^[^ ]+") -- remove args
  -- bin = vim.fn.fnamemodify(bin, ":t")
  return bin
end

function M.list_term_bufs()
  return vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(bufnr)
      return vim.bo[bufnr].buftype == "terminal"
    end)
    :totable()
end

---@return number?
function M.get_term_win()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if M.is_floating_term_win(win) then
      return win
    end
  end
end

function M.open()
  -- if alreay open, jump to
  local win = M.get_term_win()
  if win then
    log.fmt_info("open existing win: %d", win)
    vim.api.nvim_set_current_win(win)
    return
  end

  -- no term win found
  -- create a and display existing one or :term

  -- search for existing terminal buffer
  local existing_buf = nil
  if vim.v.count == 0 and M.last_visited_term_buf and vim.api.nvim_buf_is_valid(M.last_visited_term_buf) then
    existing_buf = M.last_visited_term_buf
  else
    local bufs = M.list_term_bufs()
    if #bufs > 0 then
      local i = vim.v.count1 <= #bufs and vim.v.count1 or 1
      existing_buf = bufs[i]
    end
  end

  -- create window
  local win_opts = {
    zindex = 50,
    style = "minimal",
    border = "single",
  }
  win_opts = vim.tbl_extend("force", win_opts, M.calc_layout())
  win = vim.api.nvim_open_win(existing_buf or M.create_term_buf(), true, win_opts)
  vim.api.nvim_win_set_var(win, win_flag_varname, 1)
  M.setup_term_buffer()
  vim.cmd.startinsert { bang = true }
end

function M.close()
  local win = M.get_term_win()
  if win then
    vim.api.nvim_win_close(win, true)
  end
end

function M.toggle()
  if M.is_floating_term_win(0) then
    M.close()
  else
    M.open()
  end
end

---@param dir "next" | "prev"
function M.nav(dir)
  assert(M.is_term_buf(0), "should be in term buffer")

  local bufs = M.list_term_bufs()
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

function M.delete()
  assert(M.is_term_buf(0), "should be in term buf")

  local buf = vim.api.nvim_get_current_buf()
  local bufs = M.list_term_bufs()
  if #bufs == 1 then
    if M.is_floating_term_win(0) then
      vim.api.nvim_win_close(0, true)
    end
  else
    M.nav("prev")
  end
  vim.api.nvim_buf_delete(buf, { force = true })
end

-- stylua: ignore
local _global_keymaps = {
  -- toggle
  { "<C-S-j>", M.toggle, desc = "[Term] Toggle" },

  -- move
  { "<C-S-k>k", function() M.repos('float-top') end,    desc = "[Term] Dock top"    },
  { "<C-S-k>j", function() M.repos('float-bottom') end, desc = "[Term] Dock bottom" },
  { "<C-S-k>l", function() M.repos('float-right') end,  desc = "[Term] Dock right"  },
  { "<C-S-k>h", function() M.repos('float-left') end,   desc = "[Term] Dock left"   },
  { "<C-S-k>c", function() M.repos('float-center') end, desc = "[Term] Dock center" },
}

-- stylua: ignore
local _local_keymaps = {
  -- nav
  { "<C-S-]>",  function() M.nav("next") end, desc = "[Term] Next" },
  { "<C-S-[>",  function() M.nav("prev") end, desc = "[Term] Prev" },

  -- new, delete, rename
  { "<C-S-Cr>", M.new,    desc = "[Term] New"     },
  { "<C-S-±>",  M.delete, desc = "[Term] Delete"  }, -- Ctrl+Shift+Backspace
  { "<C-S-k>r", M.rename, desc = "[Term] Rename"  },
}

function M.setup_global_keymaps()
  require("which-key").add {
    mode = { "n", "t", "i" },
    unpack(vim.deepcopy(_global_keymaps)),
  }
end

function M.setup_local_keymaps()
  assert(M.is_term_buf(0), "should be in term buffer")

  require("which-key").add {
    mode = "n",
    buffer = true,
    unpack(vim.deepcopy(_local_keymaps)),
  }
end

function M.create_term_buf()
  vim.cmd.tabnew()
  vim.cmd.terminal()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd.tabclose()
  return buf
end

On("TermOpen", M.setup_term_buffer)

On("WinEnter", function()
  if not M.is_floating_term_win(0) then
    M.close()
  end
end)

On("BufEnter", function()
  if M.is_term_buf(0) then
    M.setup_term_buffer()
  end
end)

On("VimResized", function()
  local win = M.get_term_win()
  if win then
    vim.api.nvim_win_set_config(win, M.calc_layout())
  end
end)

On("WinLeave", function(ev)
  if M.is_term_buf(ev.buf) then
    M.last_visited_term_buf = ev.buf
  end
end)

vim.api.nvim_create_user_command("Xpress", M.toggle, {})

M.setup_global_keymaps()

-- pre create 1st buf
-- after autcmds setup
M.last_visited_term_buf = M.create_term_buf()

function _G.mdx_term_winbar_render(win)
  if not M.is_term_buf(0) then
    return M.cached_winbar or ""
  end

  local bufs = M.list_term_bufs()
  assert(#bufs > 0, "no term buf found")

  local cur_buf = vim.api.nvim_win_get_buf(win)
  local parts = vim
    .iter(bufs)
    :map(function(buf)
      local texthl = buf == cur_buf and "mdx_term_winbar_item_selected" or "mdx_term_winbar_item"
      local decohl = buf == cur_buf and "mdx_term_winbar_item_selected_reverted" or "mdx_term_winbar_item_reverted"
      -- local r, l = "", ""
      local l, r = "", ""
      l, r = ("%%#%s#%s"):format(decohl, l), ("%%#%s#%s"):format(decohl, r)
      local title = M.get_title(buf)
      local ret = l .. ("%%#%s#  %s  "):format(texthl, title) .. r
      ret = ("%%%d@v:lua.mdx_term_winbar_handler@"):format(buf) .. ret .. "%X"
      return ret
    end)
    :totable()

  M.cached_winbar = "%=%#WinBar#" .. table.concat(parts, "%#WinBar# ") .. "%#WinBar#%="
  return M.cached_winbar
end

function _G.mdx_term_winbar_handler(buf)
  vim.api.nvim_win_set_buf(0, buf)
end

return M
