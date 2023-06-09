require("mudox.util.luasnip").setup_env()

local function _fold_mode_line()
  local body = "vim: fdm=marker fmr=〈,〉"
  local cs = vim.bo.commentstring
  if cs ~= "" then
    return cs:format(body)
  else
    return body
  end
end

local fold_mode_line = s("vmk", f(_fold_mode_line))

return {
  fold_mode_line,
}
