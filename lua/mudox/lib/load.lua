return function(name)
  -- protected load (require)
  local function pload(mod)
    local util = require("lazy.core.util")
    util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local modpath = require("lazy.core.cache").find(mod)
        if modpath then
          util.error(msg)
        end
      end,
    })
  end

  pload("mudox." .. name)
  pload(("mudox.%s.%s"):format(md, name))

  -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
  if vim.bo.filetype == "lazy" then
    vim.cmd("do VimResized")
  end
end
