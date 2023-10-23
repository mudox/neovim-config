-- refs
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/ui.lua `function foldtext()`
local function foldtext()
  local ret = vim.treesitter.foldtext()

  -- remove opening marker if any
  if vim.wo.foldmethod == "marker" then
    local fmr = vim.wo.foldmarker
    local pat = fmr:sub(1, fmr:find(",") - 1)
    ret[#ret][1] = ret[#ret][1]:gsub(pat, "")
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  table.insert(ret, { "  " })
  return ret
end

return {
  foldtext = foldtext,
}
