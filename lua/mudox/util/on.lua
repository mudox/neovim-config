---syntax sugar for `nvim_create_autocmd`
---
---Examples
---```lua
---  On(event, fn)
---  On(event, fn, {...})
---  On(event, {...})
---```
local function on(_, ...)
  local args = { ... }
  if #args == 2 then
    -- for `On(event, fn)`
    if type(args[2]) == "function" then
      local event, fn = ...
      vim.api.nvim_create_autocmd(event, {
        callback = fn,
      })
    else
      -- for `On(event, opts)`
      local event, opts = ...
      vim.api.nvim_create_autocmd(event, opts)
    end
  elseif #args == 3 and type(args[2]) == "function" and type(args[3]) == "table" then
    -- for `On(event, fn, { ... })`
    local event, fn, opts = ...
    vim.api.nvim_create_autocmd(event, vim.tbl_extend("keep", { callback = fn }, opts))
  else
    assert(false, "invalid arguments list")
  end
end

local M = {}

---@param fn fun(client, bufnr, event)
function M.LspAttach(fn, opts)
  opts = opts or {}
  opts.callback = function(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    fn(client, bufnr, event)
  end
  vim.api.nvim_create_autocmd("LspAttach", opts)
end

function M.User(pattern, fn, opts)
  opts = opts or {}
  opts.pattern = pattern
  opts.callback = fn
  vim.api.nvim_create_autocmd("User", opts)
end

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
  BufModifiedSet       = true,
  BufNew               = true,
  BufNewFile           = true,
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
  ChanOpen             = true,
  CmdUndefined         = true,
  CmdlineChanged       = true,
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
  CursorHold           = true,
  CursorHoldI          = true,
  CursorMoved          = true,
  CursorMovedC         = true,
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
  FileType             = true,
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
  ModeChanged          = true,
  OptionSet            = true,
  PackChanged          = true,
  PackChangedPre       = true,
  Progress             = true,
  QuickFixCmdPost      = true,
  QuickFixCmdPre       = true,
  QuitPre              = true,
  RecordingEnter       = true,
  RecordingLeave       = true,
  RemoteReply          = true,
  SafeState            = true,
  SearchWrapped        = true,
  SessionLoadPost      = true,
  SessionWritePost     = true,
  ShellCmdPost         = true,
  ShellFilterPost      = true,
  Signal               = true,
  SourceCmd            = true,
  SourcePost           = true,
  SourcePre            = true,
  SpellFileMissing     = true,
  StdinReadPost        = true,
  StdinReadPre         = true,
  SwapExists           = true,
  Syntax               = true,
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
  TermRequest          = true,
  TermResponse         = true,
  TextChanged          = true,
  TextChangedI         = true,
  TextChangedP         = true,
  TextChangedT         = true,
  TextYankPost         = true,
  UIEnter              = true,
  UILeave              = true,
  User                 = true,
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

-- stylua: ignore
M.USER_EVENTS = {
  VeryLazy = true,
}

return setmetatable(M, {
  __call = on,
  __index = function(self, name)
    if self.BUILTIN_EVENTS[name] then
      local f = function(cb, opts)
        opts = opts or {}
        opts.callback = cb
        vim.api.nvim_create_autocmd(name, opts)
      end
      self[name] = f
      return f
    elseif self.USER_EVENTS[name] then
      local f = function(cb, opts)
        opts = opts or {}
        opts.pattern = name
        opts.callback = cb
        vim.api.nvim_create_autocmd("User", opts)
      end
      self[name] = f
      return f
    else
      assert(false, "invalid event name")
    end
  end,
})
