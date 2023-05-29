local inline_fmt = s("sf", fmt([[("{1}"):format({2})]], { i(1, "format"), i(2, "args") }))

return {
  inline_fmt,
}
