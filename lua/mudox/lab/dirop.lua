local M = {}

_G.mdx_last_dirop = nil

local next = "󰅂"
local prev = "󰅁"

function M.nav_next()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  print("DirOp: 󰧀 " .. op.name .. " 󰜴 ")
  op.next()
end

function M.nav_prev()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  print("DirOp: 󰜱 " .. op.name .. " 󰧂 ")
  op.prev()
end

local once = false
function M.setup()
  assert(not once)
  once = true

  K.map({ "i", "c" }, "<C-S-]>", next)
  K.map({ "i", "c" }, "<C-S-[>", prev)

  K.nmap("<C-S-]>", M.nav_next, { desc = "DirOp forwards" })
  K.nmap("<C-S-[>", M.nav_prev, { desc = "DirOp backwards" })

  -- swizzle_nvim_set_keymap()
  -- swizzle_nvim_buf_set_keymap()
end

---add a directional operation pair
---@param op table<string, function> diectional operations table
---@param dir string ["next"|"prev"]
---@return function wrapped operation function for keymap definition
function M.wrap(op, dir)
  vim.validate("op", op, "table")
  vim.validate("op.name", op.name, "string")
  vim.validate("op.next", op.next, "function")
  vim.validate("op.prev", op.prev, "function")
  vim.validate("dir", dir, function()
    return (dir == "next" or dir == "prev"), '"next"|"prev"'
  end)

  return function()
    _G.mdx_last_dirop = op
    op[dir]()
  end
end

function M.wrap_cmd(name, n, p)
  return {
    name = name,
    next = function()
      vim.cmd("silent! " .. n)
      vim.cmd.normal { "zv", bang = true }
    end,
    prev = function()
      vim.cmd("silent! " .. p)
      vim.cmd.normal { "zv", bang = true }
    end,
  }
end

function M.wrap_key(name, n, p, bang)
  -- stylua: ignore
  return {
    name = name,
    next = function()
      pcall(vim.cmd.normal, { vim.keycode(n), bang = bang })
    end,
    prev = function()
      pcall(vim.cmd.normal, { vim.keycode(p), bang = bang })
    end,
  }
end

return M
