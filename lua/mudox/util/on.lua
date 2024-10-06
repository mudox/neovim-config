local M = {}

---@param fn fun(client, bufnr)
---@param opts table|nil
function M.lsp_attach(fn, opts)
  opts = opts or {}

  U.on("LspAttach", {
    group = opts.gid,
    desc = opts.desc,
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      fn(client, bufnr)
    end,
  })
end

---@param fn fun()
---@param opts table|nil
function M.very_lazy(fn, opts)
  opts = opts or {}

  U.on("User", {
    pattern = "VeryLazy",
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param fn fun()
---@param opts table|nil
function M.start(fn, opts)
  opts = opts or {}

  U.on("User", {
    pattern = "MdxSessionStart",
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param fn fun()
---@param opts table|nil
function M.colorscheme(fn, opts)
  opts = opts or {}

  U.on("ColorScheme", {
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---@param pattern string|string[]
---@param fn fun()
---@param opts table|nil
function M.filetype(pattern, fn, opts)
  opts = opts or {}

  U.on("FileType", {
    pattern = pattern,
    group = opts.gid,
    desc = opts.desc,
    callback = fn,
  })
end

---syntax sugar for `nvim_create_autocmd`
---
---Examples
---```lua
---  U.on(event, fn)
---  U.on(event, fn, {...})
---  U.on(event, {...})
---```
local function on(_, ...)
  local args = { ... }
  if #args == 2 then
    -- for `U.on(event, fn)`
    if type(args[2]) == "function" then
      vim.api.nvim_create_autocmd(args[1], {
        callback = args[2],
      })
    else
      -- for `U.on(event, { ... })`
      vim.api.nvim_create_autocmd(...)
    end
  elseif #args == 3 and type(args[2]) == "function" and type(args[3]) == "table" then
    -- for `U.on(event, fn, { ... })`
    vim.api.nvim_create_autocmd(args[1], vim.tbl_extend("keep", { callback = args[2] }, args[3]))
  else
    assert(false, "invalid arguments list")
  end
end

return setmetatable(M, {
  __call = on,
})
