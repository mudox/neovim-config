local string_from = s("sf", fmt('String::from("{text}");', { text = i(1, "text") }))

return {
  string_from,
}
