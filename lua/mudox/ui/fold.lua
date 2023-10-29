-- refs
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/ui.lua `function foldtext()`

local dots = "  "

local function foldline()
  local line = vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, false)[1]

  -- remove open foldmarker
  local fmr = vim.o.foldmarker
  local open_marker = fmr:sub(1, fmr:find(",") - 1)
  line = line:gsub(open_marker, "")

  -- remove prefixing comment marker
  local cstr = vim.o.commentstring
  local idx = cstr:find("%%s")
  if idx then
    local prefix = cstr:sub(1, idx - 1)
    if line:sub(1, idx - 1) == prefix then
      line = line:sub(idx)
    end
  end

  return { { line, "Keyword" }, { dots, "Normal" } }
end

local function foldtext()
  if vim.o.foldmethod == "marker" then
    return foldline()
  end

  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext()

  if not ret or type(ret) == "string" then
    return foldline()
  else
    table.insert(ret, { dots, "Normal" })
    return ret
  end
end

return {
  foldtext = foldtext,
}
