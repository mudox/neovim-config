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

---@param fn fun(client, bufnr)
function M.LspAttach(fn, opts)
  opts = opts or {}
  opts.callback = function(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    fn(client, bufnr)
  end
  vim.api.nvim_create_autocmd("LspAttach", opts)
end

function M.VeryLazy(fn, opts)
  M.user("VeryLazy", fn, opts)
end

function M.ColorScheme(fn, opts)
  opts = opts or {}
  opts.callback = fn
  vim.api.nvim_create_autocmd("ColorScheme", opts)
end

function M.filetype(pattern, fn, opts)
  opts = opts or {}
  opts.pattern = pattern
  opts.callback = fn
  vim.api.nvim_create_autocmd("FileType", opts)
end

function M.user(pattern, fn, opts)
  opts = opts or {}
  opts.pattern = pattern
  opts.callback = fn
  vim.api.nvim_create_autocmd("User", opts)
end

-- stylua: ignore
local BUILTIN_EVENTS = {
  BufAdd               = true,
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
  BufReadPre           = true,
  BufUnload            = true,
  BufWinEnter          = true,
  BufWinLeave          = true,
  BufWipeout           = true,
  BufWrite             = true,
  BufWriteCmd          = true,
  BufWritePost         = true,
  ChanInfo             = true,
  ChanOpen             = true,
  CmdlineChanged       = true,
  CmdlineEnter         = true,
  CmdlineLeave         = true,
  CmdlineLeavePre      = true,
  CmdUndefined         = true,
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
  DiffUpdated          = true,
  DirChanged           = true,
  DirChangedPre        = true,
  ExitPre              = true,
  FileAppendCmd        = true,
  FileAppendPost       = true,
  FileAppendPre        = true,
  FileChangedRO        = true,
  FileChangedShell     = true,
  FileChangedShellPost = true,
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
  MenuPopup            = true,
  ModeChanged          = true,
  OptionSet            = true,
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
  UserGettingBored     = true,
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
local USER_EVENTS = {
  VeryLazy = true,
}

return setmetatable(M, {
  __call = on,
  __index = function(t, name)
    if BUILTIN_EVENTS[name] then
      local f = function(cb, opts)
        opts = opts or {}
        opts.callback = cb
        vim.api.nvim_create_autocmd(name, opts)
      end
      t[name] = f
      return f
    elseif USER_EVENTS[name] then
      local f = function(cb, opts)
        opts = opts or {}
        opts.pattern = name
        opts.callback = cb
        vim.api.nvim_create_autocmd("User", opts)
      end
      t[name] = f
      return f
    else
      assert(false, "invalid event name")
    end
  end,
})
