-- stylua: ignore
local function c(cmd) return K.c('FzfLua ' .. cmd) end

local keys = {
  { K.s("z<Space>"), c("files"), desc = "Files" },
}

local opts = {
  fzf_colors = true,
  winopts = {
    backdrop = 100,
    border = "single",
  },
}

return {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  keys = keys,
  opts = opts,
  cond = false,
}
