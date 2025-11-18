local M = {}

---@class DirOp
---@field name string
---@field left fun() left op
---@field right fun() right op
---@field up? fun() up op
---@field down? fun() down op
---@field [string] fun()?

---@alias Dir "left" | "right" | "up" | "down"

_G.mdx_last_dirop = nil

local next = "󰅂"
local prev = "󰅁"

---@param dir Dir
---@return fun()
function M.dir_func(dir)
  return function()
    local op = _G.mdx_last_dirop

    if not op then
      print("DirOp: no last op")
      return
    end

    if not op[dir] then
      if dir == "up" then
        dir = "right"
      elseif dir == "down" then
        dir = "left"
      else
        print(("DirOp: %s missing dir %s"):format(op.name, dir))
        return
      end
    end

    print(op.name .. " -> " .. dir)
    op[dir]()
  end
end

local once = false
function M.setup()
  assert(not once)
  once = true

  K.map({ "i", "c" }, "<C-S-]>", next)
  K.map({ "i", "c" }, "<C-S-[>", prev)

  K.nmap("L", M.dir_func("left"), { desc = "DirOp left" })
  K.nmap("H", M.dir_func("right"), { desc = "DirOp right" })
  K.nmap("K", M.dir_func("up"), { desc = "DirOp up" })
  K.nmap("J", M.dir_func("down"), { desc = "DirOp down" })
end

---Perform a directional operation
---@param op DirOp
---@param dir Dir
---@return fun() wrapped operation function for keymap def
function M._perform(op, dir)
  assert(op.next == nil)
  assert(op.prev == nil)
  return function()
    _G.mdx_last_dirop = op
    if not op[dir] then
      print(("DirOp: no %s op"):format(dir))
      return
    end
    op[dir]()
  end
end

-- stylua: ignore start
function M.left(op)  return M._perform(op, "left")  end
function M.right(op) return M._perform(op, "right") end
function M.up(op)    return M._perform(op, "up")    end
function M.down(op)  return M._perform(op, "down")  end
-- stylua: ignore end

---@param name string op name
---@param l string left ex-command
---@param r string down ex-command
---@param u? string up ex-command
---@param d? string down ex-command
---@return DirOp
function M.excmd(name, l, r, u, d)
  local function _w(cmd)
    return function()
      vim.cmd("silent! " .. cmd)
      vim.cmd.normal { "zv", bang = true }
    end
  end

  local dirop = {
    name = name,
    left = _w(l),
    right = _w(r),
  }

  if u then
    dirop.up = _w(u)
  end

  if d then
    dirop.down = _w(d)
  end

  return dirop
end

---@param name string op name
---@param l string left normal command
---@param r string right normal command
---@param u? string up normal command
---@param d? string down normal command
---@return DirOp
function M.normal(name, l, r, u, d, bang)
  local function _w(lhs)
    return function()
      pcall(vim.cmd.normal, { vim.keycode(lhs), bang = bang })
    end
  end

  local dirop = {
    name = name,
    left = _w(l),
    right = _w(r),
  }

  if u then
    dirop.up = _w(u)
  end

  if d then
    dirop.down = _w(d)
  end

  return dirop
end

return M
