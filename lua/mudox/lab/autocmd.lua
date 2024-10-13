local log = Log("autocmd")

log.debug("\n\n-------- NEW SESSION ---------")

local events = { "VimEnter", "UIEnter", "WinEnter", "BufEnter", "ColorScheme" }
On(events, function(e)
  log.debug(e.event)
end)

local user_events = { "VeryLazy", "AlphaClosed" }
for _, v in ipairs(user_events) do
  On("User", function()
    log.debug("User " .. v)
  end, { pattern = v })
end
