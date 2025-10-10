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

function M.lsp_attach(fn, opts)
  opts = opts or {}
  opts.callback = function(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    fn(client, bufnr)
  end
  vim.api.nvim_create_autocmd("LspAttach", opts)
end

function M.very_lazy(fn, opts)
  M.user("VeryLazy", fn, opts)
end

function M.colorscheme(fn, opts)
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

return setmetatable(M, {
  __call = on,
})
