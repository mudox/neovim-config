local function smart_open()
  require("telescope").extensions.smart_open.smart_open {
    cwd_only = true,
    filename_first = false,
  }
end

return {
  smart_open = smart_open,
}
