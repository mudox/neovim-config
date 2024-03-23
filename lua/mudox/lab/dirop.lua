_G.mdx_last_dirop = nil

local ops = {}

local next = "󰅂"
local prev = "󰅁"

local function nav_next()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  if type(op) == "string" then
    local keys = "]" .. op
    print("DirOp: 󰧀 " .. keys .. " 󰜴 ")
    vim.cmd.normal(vim.keycode(keys))
  elseif type(op) == "table" then
    print("DirOp: 󰧀 " .. op.name .. " 󰜴 ")
    op.next()
  end
end

local function nav_prev()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  if type(op) == "string" then
    local keys = "]" .. op
    print("DirOp: 󰜱 " .. keys .. " 󰧂 ")
    vim.cmd.normal(vim.keycode(keys))
  elseif type(op) == "table" then
    print("DirOp: 󰜱 " .. op.name .. " 󰧂 ")
    op.prev()
  end
end

local function swizzle_nvim_set_keymap()
  local old = vim.api.nvim_set_keymap

  local new = function(mode, lhs, rhs, opts)
    if lhs == "󰅂d" then
      vim.print(opts)
    end

    old(mode, lhs, rhs, opts)

    if mode == "n" and #lhs == 5 then
      local dir = lhs:sub(1, 4)
      if dir == next or dir == prev then
        local op = lhs:sub(5, 5)
        local _dir = dir == next and "]" or "["
        local _lhs = _dir .. op
        opts.callback = function()
          _G.mdx_last_dirop = op
          vim.cmd.normal(lhs)
        end

        old(mode, _lhs, "", opts)
      end
    end
  end

  vim.api.nvim_set_keymap = new
end

local function swizzle_nvim_buf_set_keymap()
  local old = vim.api.nvim_buf_set_keymap

  local new = function(buffer, mode, lhs, rhs, opts)
    old(buffer, mode, lhs, rhs, opts)

    if mode == "n" and #lhs == 5 then
      local dir = lhs:sub(1, 4)
      if dir == next or dir == prev then
        local op = lhs:sub(5, 5)
        local _dir = dir == next and "]" or "["
        local _lhs = _dir .. op
        opts.callback = function()
          _G.mdx_last_dirop = op
          vim.cmd.normal(lhs)
        end
        old(buffer, mode, _lhs, "", opts)
      end
    end
  end

  vim.api.nvim_buf_set_keymap = new
end

local once = false
local function setup()
  assert(not once)
  once = true

  K.map({ "i", "c" }, "<C-S-]>", next)
  K.map({ "i", "c" }, "<C-S-[>", prev)

  K.nmap("<C-S-]>", nav_next, { remap = true, desc = "DirOp forwards" })
  K.nmap("<C-S-[>", nav_prev, { remap = true, desc = "DirOp backwards" })

  swizzle_nvim_set_keymap()
  swizzle_nvim_buf_set_keymap()
end

local function wrap(op, dir)
  vim.validate {
    ["op"] = { op, "table" },
    ["op.name"] = { op.name, "string" },
    ["op.next"] = { op.next, "function" },
    ["op.prev"] = { op.prev, "function" },
    ["dir"] = {
      dir,
      function()
        return dir == "next" or dir == "prev"
      end,
      '"next"|"prev"',
    },
  }

  return function()
    _G.mdx_last_dirop = op
    op[dir]()
  end
end

return {
  nav_next = nav_next,
  nav_prev = nav_prev,
  setup = setup,
  wrap = wrap,
}
