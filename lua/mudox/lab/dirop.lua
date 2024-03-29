_G.mdx_last_dirop = nil

local next = "󰅂"
local prev = "󰅁"

local function nav_next()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  vim.print(op)
  print("DirOp: 󰧀 " .. op.name .. " 󰜴 ")
  op.next()
end

local function nav_prev()
  if not _G.mdx_last_dirop then
    print("DirOp: no last op")
    return
  end

  local op = _G.mdx_last_dirop
  print("DirOp: 󰜱 " .. op.name .. " 󰧂 ")
  op.prev()
end

local once = false
local function setup()
  assert(not once)
  once = true

  K.map({ "i", "c" }, "<C-S-]>", next)
  K.map({ "i", "c" }, "<C-S-[>", prev)

  K.nmap("<C-S-]>", nav_next, { remap = true, desc = "DirOp forwards" })
  K.nmap("<C-S-[>", nav_prev, { remap = true, desc = "DirOp backwards" })

  -- swizzle_nvim_set_keymap()
  -- swizzle_nvim_buf_set_keymap()
end

---add a directional operation pair
---@param op table<string, function> diectional operations table
---@param dir string ["next"|"prev"]
---@return function wrapped operation function for keymap definition
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
