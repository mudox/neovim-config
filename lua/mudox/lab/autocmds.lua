local log = {
  ok = false,
  fd = (function()
    local tty = vim
        .system({ "tmux", "display-message", "-p", "-t", "Neovim:Autocmds.1", "#{pane_tty}" }, { text = true })
        :wait().stdout
        :gsub("%s", "")
    assert(tty:find("/dev/ttys"))

    local fd = vim.uv.fs_open(tty, "w", 420)
    assert(fd)

    return fd
  end)(),
  queue = {},
  writing = false,
}

On.VeryLazy(function()
  log.ok = true
  log:flush()
end)

setmetatable(log, {
  __call = function(self, text)
    table.insert(self.queue, text .. "\n")
    self:flush()
  end,
})

function log:flush()
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

function log:close()
  if self.fd then
    vim.uv.fs_close(self.fd)
    self.fd = nil
  end
end

local M = {
  interval = 500, -- ms
  timestamp = 0,
}

-- stylua: ignore
-- from $VIMRUNTIME/lua/vim/_meta/api_keysets.lua, `gf` to open
M.BUILTIN_EVENTS = {
  BufAdd               = true,
  BufCreate            = true,
  BufDelete            = true,
  BufEnter             = true,
  BufFilePost          = true,
  BufFilePre           = true,
  BufHidden            = true,
  BufLeave             = true,
  BufModifiedSet       = false,
  BufNew               = false,
  BufNewFile           = false,
  BufRead              = true,
  BufReadCmd           = true,
  BufReadPost          = true,
  BufReadPre           = true,
  BufUnload            = true,
  BufWinEnter          = true,
  BufWinLeave          = true,
  BufWipeout           = true,
  BufWrite             = true,
  BufWriteCmd          = true,
  BufWritePost         = true,
  BufWritePre          = true,
  ChanInfo             = true,
  ChanOpen             = false,
  CmdUndefined         = true,
  CmdlineChanged       = false,
  CmdlineEnter         = true,
  CmdlineLeave         = true,
  CmdlineLeavePre      = true,
  CmdwinEnter          = true,
  CmdwinLeave          = true,
  ColorScheme          = true,
  ColorSchemePre       = true,
  CompleteChanged      = true,
  CompleteDone         = true,
  CompleteDonePre      = true,
  CursorHold           = false,
  CursorHoldI          = false,
  CursorMoved          = false,
  CursorMovedC         = false,
  CursorMovedI         = true,
  DiagnosticChanged    = true,
  DiffUpdated          = true,
  DirChanged           = true,
  DirChangedPre        = true,
  EncodingChanged      = true,
  ExitPre              = true,
  FileAppendCmd        = true,
  FileAppendPost       = true,
  FileAppendPre        = true,
  FileChangedRO        = true,
  FileChangedShell     = true,
  FileChangedShellPost = true,
  FileEncoding         = true,
  FileReadCmd          = true,
  FileReadPost         = true,
  FileReadPre          = true,
  FileType             = false,
  FileWriteCmd         = true,
  FileWritePost        = true,
  FileWritePre         = true,
  FilterReadPost       = true,
  FilterReadPre        = true,
  FilterWritePost      = true,
  FilterWritePre       = true,
  FocusGained          = true,
  FocusLost            = true,
  FuncUndefined        = true,
  GUIEnter             = true,
  GUIFailed            = true,
  InsertChange         = true,
  InsertCharPre        = true,
  InsertEnter          = true,
  InsertLeave          = true,
  InsertLeavePre       = true,
  LspAttach            = true,
  LspDetach            = true,
  LspNotify            = true,
  LspProgress          = true,
  LspRequest           = true,
  LspTokenUpdate       = true,
  MarkSet              = true,
  MenuPopup            = true,
  ModeChanged          = false,
  OptionSet            = false,
  PackChanged          = true,
  PackChangedPre       = true,
  Progress             = true,
  QuickFixCmdPost      = true,
  QuickFixCmdPre       = true,
  QuitPre              = true,
  RecordingEnter       = true,
  RecordingLeave       = true,
  RemoteReply          = true,
  SafeState            = false,
  SearchWrapped        = true,
  SessionLoadPost      = true,
  SessionWritePost     = true,
  ShellCmdPost         = true,
  ShellFilterPost      = true,
  Signal               = true,
  SourceCmd            = false,
  SourcePost           = false,
  SourcePre            = false,
  SpellFileMissing     = true,
  StdinReadPost        = true,
  StdinReadPre         = true,
  SwapExists           = true,
  Syntax               = false,
  TabClosed            = true,
  TabEnter             = true,
  TabLeave             = true,
  TabNew               = true,
  TabNewEntered        = true,
  TermChanged          = true,
  TermClose            = true,
  TermEnter            = true,
  TermLeave            = true,
  TermOpen             = true,
  TermRequest          = false,
  TermResponse         = false,
  TextChanged          = false,
  TextChangedI         = false,
  TextChangedP         = false,
  TextChangedT         = false,
  TextYankPost         = true,
  UIEnter              = true,
  UILeave              = true,
  VimEnter             = true,
  VimLeave             = true,
  VimLeavePre          = true,
  VimResized           = true,
  VimResume            = true,
  VimSuspend           = true,
  WinClosed            = true,
  WinEnter             = true,
  WinLeave             = true,
  WinNew               = true,
  WinResized           = true,
  WinScrolled          = true,
}

function M:sep()
  local now = vim.uv.hrtime()

  if self.timestamp == 0 then
    self.timestamp = now
    return
  end

  local ms = (now - self.timestamp) / 1e6
  if ms > self.interval then
    log(("\n%dms ellapsed\n"):format(ms))
  end

  self.timestamp = now
end

function M:start()
  log("\27[2J\27[3J\27[H")
  -- -- log.trace("\n\n-------- NEW SESSION ---------")

  local events = vim.tbl_filter(function(name)
    return self.BUILTIN_EVENTS[name]
  end, vim.tbl_keys(self.BUILTIN_EVENTS))
  -- local events = { "BufNew", "BufWinEnter", "BufEnter", "BufNewFile", "FileType", "Syntax", "BufRead", "WinEnter" }
  On(events, function(ev)
    self:sep()
    log(ev.event)
  end, { group = V.ag.autocmds })

  -- local user_events = { "VeryLazy", "LazyVimStarted" }
  -- On.User("*", function(ev)
  --   self:sep()
  --   log("User " .. ev.match)
  -- end, { group = V.ag.autocmds })
end

return M
