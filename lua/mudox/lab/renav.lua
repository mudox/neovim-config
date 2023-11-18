_G.mdx_renav_last_target = nil

local next = "󰅂"
local prev = "󰅁"

local function nav_next()
  if not _G.mdx_renav_last_target then
    return
  end
  local keys = "]" .. _G.mdx_renav_last_target
  print("[Renav] " .. keys)
  vim.cmd.normal(vim.keycode(keys))
end

local function nav_prev()
  if not _G.mdx_renav_last_target then
    return
  end
  local keys = "[" .. _G.mdx_renav_last_target
  print("[Renav] " .. keys)
  vim.cmd.normal(vim.keycode(keys))
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
        local target = lhs:sub(5, 5)
        local _dir = dir == next and "]" or "["
        local _lhs = _dir .. target
        opts.callback = function()
          _G.mdx_renav_last_target = target
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
        local target = lhs:sub(5, 5)
        local _dir = dir == next and "]" or "["
        local _lhs = _dir .. target
        opts.callback = function()
          _G.mdx_renav_last_target = target
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

  K.nmap("<C-S-]>", nav_next, { remap = true, desc = "Renav forwards" })
  K.nmap("<C-S-[>", nav_prev, { remap = true, desc = "Renav backwards" })

  swizzle_nvim_set_keymap()
  swizzle_nvim_buf_set_keymap()
end

local function wrap(target, fn)
  return function()
    _G.mdx_renav_last_target = target
    fn()
  end
end

return {
  nav_next = nav_next,
  nav_prev = nav_prev,
  setup = setup,
  wrap = wrap,
}
