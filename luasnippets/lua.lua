---@diagnostic disable: undefined-global

local inline_fmt = s("sf", fmt([[("{1}"):format({2})]], { i(1, "format"), i(2, "args") }))

local autocmd = s(
  "au",
  fmt(
    [[
      local gid = vim.api.nvim_create_augroup({group_name}, {{ clear = true }})
      vim.api.nvim_create_autocmd("{event}", {{
        group = gid,
        desc = "{desc}",
        callback = function(event)
          {content}
        end,
      }})
    ]],
    {
      group_name = i(1, "group name"),
      event = i(2, "event"),
      desc = i(3, "description"),
      content = i(4, "callback"),
    }
  )
)

return {
  inline_fmt,
  autocmd,
}
