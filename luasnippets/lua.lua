local string_format = s("sf", fmt([[("{1}"):format({2})]], { i(1, "format"), i(2, "args") }))

local autocmd = (function()
  local autocmd_simple = fmt(
    [[
      On("{event}", {{
        callback = function(event)
          {content}
        end,
      }})
    ]],
    {
      event = i(1, "event"),
      content = i(2, "callback"),
    }
  )

  local autocmd_complete = fmt(
    [[
      local gid = vim.api.nvim_create_augroup({group_name}, {{ clear = true }})
      On("{event}", {{
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

  return s("au", c(1, { autocmd_simple, autocmd_complete }))
end)()

local local_function = (function()
  local head = c(1, {
    fmt("local function {name}({args})", { name = i(1, ""), args = i(2) }),
    fmt("local {name} = function({args})", { name = i(1, ""), args = i(2) }),
  })

  local format = [[
    {head}
      {body}
    end
  ]]

  return s(
    "lf",
    fmt(format, {
      head = head,
      body = i(2),
    })
  )
end)()

local lambda = (function()
  return s(
    "la",
    c(1, {
      fmt("function({args}) {body} end", { args = i(1), body = i(2, "body") }),
      fmt("function({args})\n  {body}\nend", { args = i(1), body = i(2, "body") }),
    })
  )
end)()

local stylua_ignore = s("si", t("-- stylua: ignore"))

return {
  autocmd,
  string_format,
  lambda,
  local_function,
  stylua_ignore,
}
