local M = {}

---@class arrows.Op
---@field name string
---@field left fun() left op
---@field right fun() right op
---@field up? fun() up op
---@field down? fun() down op
---@field notify? fun(dir) custom notify logic
---@field [string] fun()?

---@alias arrows.Dir "left" | "right" | "up" | "down"

-- stylua: ignore
local diricon = {
  up    = '↑',
  down  = '↓',
  left  = '←',
  right = '→',
}

---@param dir arrows.Dir
---@return fun()
function M.dir_func(dir)
  return function()
    -- fetch op
    local op = V.last_arrow_op
    if not op then
      print("Arrows: no last op")
      return
    end

    -- dir fallback: up -> left, down -> right
    if not op[dir] then
      if dir == "up" then
        dir = "left"
      elseif dir == "down" then
        dir = "right"
      else
        print(("Arrows: %s missing dir %s"):format(op.name, dir))
        return
      end
    end

    -- notify
    if op.notify then
      op.notify(dir)
    else
      print(op.name .. " " .. diricon[dir])
    end

    -- execute
    op[dir]()
  end
end

local once = false
function M.setup()
  assert(not once)
  once = true

  -- stylua: ignore start
  K.nmap("<Left>",  M.dir_func("left"),  { desc = "[Arrow] Left"  })
  K.nmap("<Right>", M.dir_func("right"), { desc = "[Arrow] Right" })
  K.nmap("<Up>",    M.dir_func("up"),    { desc = "[Arrow] Up"    })
  K.nmap("<Down>",  M.dir_func("down"),  { desc = "[Arrow] Down"  })
  -- stylua: ignore end
end

---Perform a directional operation
---@param op arrows.Op
---@param dir arrows.Dir
---@return fun() wrapped operation function for keymap def
function M._perform(op, dir)
  assert(op.next == nil)
  assert(op.prev == nil)
  return function()
    V.last_arrow_op = op
    if not op[dir] then
      print(("Arrows: no %s op"):format(dir))
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
---@return arrows.Op
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
---@return arrows.Op
function M.normal(name, l, r, u, d)
  local function _w(lhs)
    return function()
      pcall(vim.cmd.normal, { lhs, bang = true })
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
