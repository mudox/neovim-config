-- vim: fml& fdn& fdm=marker fmr=〈,〉
---@diagnostic disable: undefined-global

local inline_string_format = s("sf", fmt([[("{1}"):format({2})]], { i(1, "format"), i(2, "args") }))

-- autocmd 〈

local autocmd_simple = fmt(
  [[
    vim.api.nvim_create_autocmd("{event}", {{
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

local autocmd = s("au", c(1, { autocmd_simple, autocmd_complete }))

-- lsp attach 〉

-- local function 〈

local head = c(1, {
  fmt("local function {name}()", { name = i(1, "name") }),
  fmt("local {name} = function()", { name = i(1, "name") }),
})

local format = [[
  {head}
    {body}
  end
]]

local local_funtion = s(
  "lf",
  fmt(format, {
    head = head,
    body = i(0),
  })
)

-- local function 〉

local stylua_ignore = s("si", t("-- stylua: ignore"))

return {
  autocmd,
  inline_string_format,
  local_funtion,
  stylua_ignore,
}
