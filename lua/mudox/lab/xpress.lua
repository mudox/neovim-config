local log = Log("xpress")
log.info("\27[2J\27[3J\27[H")

local wv_name = "xpress"
local title_bv_name = "xpress_title"

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

local M = {
  -- stylua: ignore
  icon = {
    left  = "",
    right = "",
  },

  ---@type mdx.xpress.WinPos
  pos = "float-bottom",
  margin = 4,
  pinned = false,
  last_visited_term_buf = nil,
}

local function assert_buf(buf)
  assert(M.is_term_buf(buf), "should be in terminal buffer")
end

local function assert_win(win)
  assert(M.is_term_buf(win), "should be in xpress window")
  assert_buf(vim.api.nvim_win_get_buf(win))
end

---reposition terminal win
---@param pos mdx.xpress.WinPos?
function M.repos(pos)
  M.pos = pos or M.pos

  local win = M.get_floating_term_win()
  if win then
    vim.api.nvim_win_set_config(win, M.calc_layout())
  else
    M.open()
  end
end

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
  assert_buf(0)

  vim.cmd.terminal()
end

function M.rename()
  assert_buf(0)

  local buf = vim.api.nvim_get_current_buf()
  vim.ui.input({ prompt = "New Name: " }, function(name)
    if name and name ~= "" then
      vim.api.nvim_buf_set_var(buf, title_bv_name, name)
      vim.cmd.redrawstatus { bang = true }
    end
  end)
end

function M.setup_term_buffer()
  assert_buf(0)

  vim.wo.winbar = ("%%!v:lua.xpress_winbar(%d)"):format(vim.api.nvim_get_current_win())
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  M.setup_local_keymaps()

  if M.is_floating_term_win(0) then
    vim.wo.winhl = "NormalFloat:mdx_block_float,FloatBorder:mdx_block_float_border,"
      .. "WinBar:mdx_float_term_winbar,WinBarNC:mdx_float_term_winbar"
  else
    vim.wo.winhl = "WinBar:xpress_winbar"
  end
end

function M.is_floating_term_win(win)
  return pcall(vim.api.nvim_win_get_var, win, wv_name)
end

function M.is_term_buf(buf)
  -- fzf would set its terminal buf's `ft` option
  return vim.bo[buf].buftype == "terminal" and vim.bo[buf].ft == ""
end

function M.get_title(buf)
  assert(M.is_term_buf(buf))

  local ok, title = pcall(vim.api.nvim_buf_get_var, buf, title_bv_name)
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
function M.get_floating_term_win()
  local wins = vim.iter(vim.api.nvim_tabpage_list_wins(0)):filter(M.is_floating_term_win):totable()
  log.fmt_debug("list wins: %s", wins)
  -- assert(#wins <= 1, ("%d flating xpress wins found, at most 1 is allowed"):format(#wins))
  return wins[1]
end

function M.open()
  -- if alreay open, jump to
  local win = M.get_floating_term_win()
  log.fmt_debug("found win: %s", vim.inspect(win))
  if win then
    log.fmt_info("open existing win: %d", win)
    vim.api.nvim_set_current_win(win)
    return
  end

  log.info("no win found, create a new one")

  -- term buf
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
  vim.api.nvim_win_set_var(win, wv_name, 1)
  M.setup_term_buffer()
  vim.cmd.startinsert { bang = true }
end

function M.close()
  local win = M.get_floating_term_win()
  if win then
    log.fmt_info("close win %d", win)
    vim.api.nvim_win_close(win, true)
  end
end

function M.toggle()
  if M.is_floating_term_win(0) then
    if not M.pinned then
      log.debug("close")
      M.close()
    else
      log.debug("leave")
      vim.cmd.wincmd("p")
    end
  else
    M.open()
  end
end

vim.api.nvim_set_hl(0, "xpress_pin", { fg = "bg" })
function M.toggle_pinned()
  assert_win(0)

  M.pinned = not M.pinned

  if M.pinned then
    vim.api.nvim_set_hl(0, "xpress_pin", { fg = "green" })
    log.fmt_debug("pinned: %s", vim.api.nvim_get_hl_id_by_name("xpress_pin"))
  else
    vim.api.nvim_set_hl(0, "xpress_pin", { fg = "bg" })
    log.fmt_debug("unpinned: %s", vim.api.nvim_get_hl_id_by_name("xpress_pin"))
  end
end

---@param dir "next" | "prev"
function M.nav(dir)
  assert_buf(0)

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
  assert_buf(0)

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
local _local_keymaps = {
  -- nav
  { "<C-S-]>",  function() M.nav("next") end, desc = "[Term] Next"          },
  { "<C-S-[>",  function() M.nav("prev") end, desc = "[Term] Prev"          },

  -- new, delete, rename
  { "<C-S-Cr>", M.new,                        desc = "[Term] New"           },
  { "<C-S-±>",  M.delete,                     desc = "[Term] Delete"        }, -- Ctrl+Shift+Backspace
  { "<C-S-k>r", M.rename,                     desc = "[Term] Rename"        },

  -- pin
  { "<C-S-k>p", M.toggle_pinned,              desc = "[Term] Toggle pinned" },
}

-- stylua: ignore
function M.setup_global_keymaps()
  require("which-key").add {
    {
      mode = { "n", "t", "i" },
      -- toggle
      { "<C-S-j>",  M.toggle, desc = "[Xpress] Toggle" },
      { "<C-S-k>x", M.close,  desc = "[Xpress] Close"  },

      -- move
      { "<C-S-k>k", function() M.repos('float-top') end,    desc = "[Xpress] Dock top"    },
      { "<C-S-k>j", function() M.repos('float-bottom') end, desc = "[Xpress] Dock bottom" },
      { "<C-S-k>l", function() M.repos('float-right') end,  desc = "[Xpress] Dock right"  },
      { "<C-S-k>h", function() M.repos('float-left') end,   desc = "[Xpress] Dock left"   },
      { "<C-S-k>c", function() M.repos('float-center') end, desc = "[Xpress] Dock center" },
    },
    {
      mode = 't',
      unpack(vim.deepcopy(_local_keymaps))
    }
  }
end

-- stylua: ignore
function M.setup_local_keymaps()
  assert_buf(0)

  require("which-key").add {
    mode = "n", buffer = true,
    unpack(vim.deepcopy(_local_keymaps))
  }
end

function M.create_term_buf()
  vim.cmd.tabnew()
  vim.cmd.terminal()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd.tabclose()
  return buf
end

function _G.xpress_winbar(win)
  local bufs = M.list_term_bufs()
  assert(#bufs > 0, "no term buf found")

  local cur_buf = vim.api.nvim_win_get_buf(win)
  local parts = vim
    .iter(bufs)
    :map(function(buf)
      local texthl = buf == cur_buf and "xpress_winbar_item_selected" or "xpress_winbar_item"
      local decohl = buf == cur_buf and "xpress_winbar_item_selected_reverted" or "xpress_winbar_item_reverted"
      -- local r, l = "", ""
      local l, r = ("%%#%s#%s"):format(decohl, M.icon.left), ("%%#%s#%s"):format(decohl, M.icon.right)
      local title = M.get_title(buf)
      local ret = l .. ("%%#%s#  %s  "):format(texthl, title) .. r
      ret = ("%%%d@v:lua.xpress_winbar_handler@"):format(buf) .. ret .. "%X"
      return ret
    end)
    :totable()

  local ret = "%=%#WinBar#" .. table.concat(parts, "%#WinBar# ") .. "%#WinBar#%="

  -- local pin = ("%%#%s#%s%%#%s# 󰐃 "):format(
  --   "xpress_winbar_item_selected_reverted",
  --   M.icon.left,
  --   "xpress_winbar_item_selected"
  -- )

  local pin = "%#xpress_pin#[pinned]"
  ret = ret .. pin

  return ret
end

function _G.xpress_winbar_handler(buf)
  vim.api.nvim_win_set_buf(0, buf)
end

local function init()
  On("TermOpen", function()
    log.trace("event TermOpen")

    M.setup_term_buffer()
  end)

  On("WinEnter", function()
    log.trace("event WinEnter")
    if not M.is_floating_term_win(0) and not M.pinned then
      log.info("autoclose unpinned win")
      M.close()
    end
  end)

  On("BufEnter", function()
    log.trace("event BufEnter")

    if M.is_term_buf(0) then
      M.setup_term_buffer()
      vim.cmd.startinsert { bang = true }
    end
  end)

  On("VimResized", function()
    log.trace("event VimResized")

    local win = M.get_floating_term_win()
    if win then
      vim.api.nvim_win_set_config(win, M.calc_layout())
    end
  end)

  On("WinLeave", function(ev)
    log.trace("event WinLeave")

    if M.is_term_buf(ev.buf) then
      M.last_visited_term_buf = ev.buf
    end
  end)

  vim.api.nvim_create_user_command("Xpress", M.toggle, {})

  M.setup_global_keymaps()

  M.last_visited_term_buf = M.create_term_buf()
end

init()

return M
