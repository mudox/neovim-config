-- vim: fdm=marker fmr=〈,〉
---@diagnostic disable: undefined-global

local inline_string_format = s("sf", fmt([[("{1}"):format({2})]], { i(1, "format"), i(2, "args") }))

-- lsp attach 〈

local au_lsp_attach = s(
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

local test_auto = s("name!", t("mudox"))

local manual = {
  au_lsp_attach,
  inline_string_format,
  local_funtion,
}

local auto = {
  test_auto,
}

return manual, auto
