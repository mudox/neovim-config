--- b:mdx_term_title
--- w:mdx_float_term

local M = {}

local log = Log("xpress")

local win_flag_varname = "mdx_float_term"
local title_varname = "mdx_term_title"

function M.recalculate_layout()
  local total_lines = vim.o.lines
  local total_cols = vim.o.columns
  local height = math.max(10, math.floor(total_lines / 3))
  local margin = 4
  local width = total_cols - margin * 2 - 3
  return {
    anchor = "SW",
    row = total_lines - margin - 1,
    col = margin,
    width = width,
    height = height,
  }
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
  M.setup_buffer_keymaps()

  if M.is_floating_term_win(0) then
    vim.wo.winhl = "NormalFloat:mdx_block_float,FloatBorder:mdx_block_float_border,WinBar:mdx_float_term_winbar"
  else
    vim.wo.winhl = "WinBar:mdx_term_winbar"
  end
end

---param win number 0 for current window
function M.is_floating_term_win(win)
  return pcall(vim.api.nvim_win_get_var, win, win_flag_varname)
end

---param win number 0 for current buffer
function M.is_term_buf(buf)
  return vim.bo[buf].buftype == "terminal"
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
  log.fmt_debug("count: %d, count1: %d", vim.v.count, vim.v.count1)

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
  if vim.v.count == 0 and M.last_visited_term_buf then
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
    relative = "editor",
    zindex = 50,
    style = "minimal",
    border = "single",
  }
  win_opts = vim.tbl_extend("force", win_opts, M.recalculate_layout())
  log.fmt_debug("win_opts: %s", win_opts)
  local _buf = vim.api.nvim_create_buf(false, true)
  log.fmt_debug("_buf: %d", _buf)
  win = vim.api.nvim_open_win(existing_buf or _buf, true, win_opts)
  vim.api.nvim_win_set_var(win, win_flag_varname, 1)

  -- buffer
  if existing_buf == nil then
    log.info("new terminal")
    vim.cmd.terminal()
  end
  M.setup_term_buffer()
  vim.cmd.startinsert { bang = true }

  vim.cmd.bwipeout(_buf)
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

  local bufs = M.list_term_bufs()
  if #bufs == 1 then
    if M.is_floating_term_win(0) then
      vim.api.nvim_win_close(0, true)
    end
    vim.api.nvim_buf_delete(0, { force = true })
  else
    local buf = vim.api.nvim_get_current_buf()
    M.nav("prev")
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

-- stylua: ignore
local in_win_keymaps = {
  { "<C-S-]>",  function() M.nav("next") end, desc = "[Term] Next" },
  { "<C-S-[>",  function() M.nav("prev") end, desc = "[Term] Prev" },

  { "<C-S-Cr>", M.new,    desc = "[Term] New"     },
  { "<C-S-±>",  M.delete, desc = "[Term] Delete"  }, -- Ctrl+Shift+Backspace

  { "<C-S-k>r", M.rename, desc = "[Term] Rename"  },
}

-- stylua: ignore
function M.setup_global_keymaps()
  require("which-key").add {
    {
      mode = { "n", "t", "i", "v" },
      { "<C-S-j>", M.toggle, desc = "[Term] Toggle" },
    },
    {
      mode = 't',
      unpack(vim.deepcopy(in_win_keymaps))
    }
  }
end

function M.setup_buffer_keymaps()
  assert(M.is_term_buf(0), "should be in term buffer")

  require("which-key").add {
    mode = "n",
    buffer = true,
    unpack(vim.deepcopy(in_win_keymaps)),
  }
end

function M.preload()
  vim.cmd.tabnew()
  vim.cmd.terminal()
  vim.cmd.tabclose()
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
  log.fmt_debug("vim resized: %s", M.recalculate_layout())
end)

On("WinLeave", function(ev)
  if M.is_term_buf(ev.buf) then
    M.last_visited_term_buf = ev.buf
  end
end)

M.setup_global_keymaps()

-- after autcmds setup
M.preload()

function _G.mdx_term_winbar_render(win)
  if not M.is_term_buf(0) then
    return M.cached_winbar or ""
  end

  local bufnrs = M.list_term_bufs()
  assert(#bufnrs > 0, "no term buf found")

  local cur_buf = vim.api.nvim_win_get_buf(win)
  local parts = vim
    .iter(bufnrs)
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
