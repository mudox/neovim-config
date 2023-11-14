local last_target

local next = "󰅂"
local prev = "󰅁"

local function nav_next()
  if not last_target then
    return
  end
  vim.cmd.normal(next .. last_target)
end

local function nav_prev()
  if not last_target then
    return
  end
  vim.cmd.normal(prev .. last_target)
end

local once = false
local function setup()
  assert(not once)
  once = true

  K.imap("<C-S-]>", next)
  K.imap("<C-S-[>", prev)

  K.nmap("<C-S-]>", nav_next, { remap = true, desc = "Renav forwards" })
  K.nmap("<C-S-[>", nav_prev, { remap = true, desc = "Renav backwards" })

  local orig_set = vim.keymap.set
  local function new_set(modes, lhs, rhs, opts)
    modes = type(modes) == "string" and { modes } or modes

    if vim.tbl_contains(modes, "n") and #lhs == 5 then
      local dir = lhs:sub(1, 4)
      if dir == next or dir == prev then
        -- print("[Renav] wrap " .. lhs .. " in " .. vim.inspect(modes))

        local target = lhs:sub(5, 5)
        local _dir = dir == next and "]" or "["
        local _lhs = _dir .. target

        local _rhs = rhs
        if type(rhs) == "function" then
          _rhs = function()
            last_target = target
            rhs()
          end
        else
          print("[Renav] unprocessed keymap " .. lhs)
        end

        orig_set(modes, _lhs, _rhs, opts)
      end
    end

    orig_set(modes, lhs, rhs, opts)
  end

  vim.keymap.set = new_set
end

return {
  nav_next = nav_next,
  nav_prev = nav_prev,
  setup = setup,
}
