local function buf(ev)
  return ("b=%d fn=%s ft=%s"):format(ev.buf, vim.fn.bufname(ev.buf), vim.bo[ev.buf].filetype)
end

local function win()
  local w = vim.fn.getwininfo(vim.fn.win_getid())[1]
  return ("w=%d(%d)"):format(w.winnr, w.winid)
end

-- for all event names see $VIMRUNTIME/lua/vim/_meta/api_keysets.lua, `gf` to open
local events = {
  VimEnter = function(ev)
    return ""
  end,
  UIEnter = function(ev)
    return ""
  end,

  BufEnter = function(ev)
    return buf(ev)
  end,
  BufNew = function(ev)
    return buf(ev)
  end,
  BufNewFile = function(ev)
    return buf(ev)
  end,
  BufReadPost = function(ev)
    return buf(ev)
  end,
  BufWinEnter = function(ev)
    return buf(ev) .. " " .. win(ev)
  end,
  BufLeave = function(ev)
    return buf(ev)
  end,

  FileType = function(ev)
    return buf(ev)
  end,
  Syntax = function(ev)
    return buf(ev)
  end,

  WinEnter = function(ev)
    return win(ev)
  end,
  WinLeave = function(ev)
    return buf(ev) .. " " .. win(ev)
  end,
}

local M = {
  ok = false,
  fd = nil,
  queue = {},
  writing = false,

  interval = 500, -- ms
  timestamp = 0,
}

function M:open()
  vim.system({ "tmux", "new-window", "-n", "Autocmds", "-Sd" }):wait()
  local tty = vim
    .system({ "tmux", "display-message", "-p", "-t", "Neovim:Autocmds.1", "#{pane_tty}" }, { text = true })
    :wait().stdout
    :gsub("%s+", "")

  local fd = vim.uv.fs_open(tty, "w", 420)
  assert(fd)

  self.fd = fd
end

function M:log(text)
  if V.log_autocmds == false then
    return
  end

  table.insert(self.queue, text .. "\n")
  self:flush()
end

function M:sep()
  local now = vim.uv.hrtime()

  if self.timestamp == 0 then
    self.timestamp = now
    return
  end

  local ms = (now - self.timestamp) / 1e6
  if ms > self.interval then
    self:log(("\n%dms ellapsed\n"):format(ms))
  end

  self.timestamp = now
end

function M:flush()
  assert(self.fd)
  if not self.ok or self.writing or #self.queue == 0 then
    return
  end

  self.writing = true
  local chunk = table.concat(self.queue)
  self.queue = {}

  vim.uv.fs_write(self.fd, chunk, -1, function()
    self.writing = false
    self:flush()
  end)
end

function M:close()
  if self.fd then
    vim.uv.fs_close(self.fd)
    self.fd = nil
  end
end

function M:start()
  M:open()
  self:log("\27[2J\27[3J\27[H") -- clear screen & scrollback

  On(vim.tbl_keys(events), function(ev)
    if V.log_autocmds == false then
      return
    end

    self:sep()
    self:log(ev.event .. " " .. events[ev.event](ev))
  end, { group = V.ag.autocmds })
end

On.VeryLazy(function()
  M.ok = true
  M:flush()
end)

return M
