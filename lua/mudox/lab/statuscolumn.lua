local MAX_GREY_LEVEL = 8
local MIN_GREY = 30

local function color(level)
  assert(level > 0)

  level = math.min(MAX_GREY_LEVEL, level)
  local stride = math.floor((255 - MIN_GREY) / MAX_GREY_LEVEL)

  -- local n = MIN_GREY + (level - 1) * stride
  local n = 255 - (MAX_GREY_LEVEL - level) * stride
  assert(n <= 255)

  return ("#%X%X%X"):format(n, n, n)
end

-- setup highlights
for n = 1, MAX_GREY_LEVEL do
  vim.api.nvim_set_hl(0, "MdxFoldGrey" .. n, {
    fg = color(n),
  })
end

local function ribbon(level)
  local bar = "┃"
  return ("%%#MdxFoldGrey%d#" .. bar):format(math.min(MAX_GREY_LEVEL, level))
end

return function()
  local foldlevel = vim.fn.foldlevel(vim.v.lnum)
  local foldlevel_before = vim.fn.foldlevel(math.max(1, vim.v.lnum - 1))
  local foldlevel_after = vim.fn.foldlevel(math.min(vim.fn.line("$"), vim.v.lnum + 1))
  local foldclosed = vim.fn.foldclosed(vim.v.lnum)

  if foldlevel == 0 then
    return " "
  end

  -- start line of closed fold
  if foldclosed == vim.v.lnum then
    return "󰅂"
  end

  -- start line of a opened fold level
  -- if foldlevel > foldlevel_before then
  --   return " "
  -- end
  --
  -- -- end line of a opened fold level
  -- if foldlevel > foldlevel_after then
  --   return " "
  -- end

  -- middle line of a opened fold level
  return ribbon(foldlevel)
end
