U.luasnip.setup_env()

local function _fold_mode_line()
  local body = "vim: fml& fdn& fdm=marker fmr=〈,〉"
  local cs = vim.bo.commentstring
  if cs ~= "" then
    return cs:format(body)
  else
    return body
  end
end

local fold_mode_line = s("vmk", f(_fold_mode_line))

local test = s(
  "test",
  c(1, {
    t("TODO"),
    t("FIXME"),
    t("IDEA"),
    t("ISSUE"),
    t("NOTE"),
    t("IMPORTANT"),
  })
)

return {
  fold_mode_line,
  test,
}
