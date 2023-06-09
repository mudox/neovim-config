local function br(count)
  count = count or 1
  count = math.max(1, count)

  local text = { "" }
  for _ = 1, count do
    table.insert(text, "")
  end

  return require("luasnip").text_node(text)
end

local function sp(count)
  count = count or 1
  count = math.max(1, count)

  local text = { "" }
  for _ = 1, count do
    text = text .. " "
  end

  return require("luasnip").text_node(text)
end

local function setup_env()
  local env = getfenv(2)
  env.br = br
  env.sp = sp

  ---@diagnostic disable-next-line: param-type-mismatch
  setfenv(2, env)
end

return {
  setup_env = setup_env,
}
