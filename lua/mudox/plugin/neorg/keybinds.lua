local function hook(k)
  local prefix = "<leader>e"

  -- gtd
  local keys = { "u", "p", "d", "h", "c", "r", "i" }
  for _, key in ipairs(keys) do
    k.remap_key("norg", "n", "t" .. key, "gt" .. key)
  end

  k.remap_key("norg", "n", "<C-Space>", "<C-Enter>") -- toggle task done

  -- list
  k.remap_key("norg", "n", "lt", prefix .. "t") -- toggle list type
  k.remap_key("norg", "n", "li", prefix .. "T") -- invert each list item individually

  -- indent
  -- - normal mode: `<<`, `>>`, `<,`, `>`.
  -- - insert mode: `<C-t>`, `<C-d>`

  -- link
  -- <Cr>, gd, gf, gF, <M-Cr>

  -- itero
  -- <M-Cr> in insert mode

  -- note
  k.remap_key("norg", "n", "nn", prefix .. "n") -- create new note

  -- toc
  -- `gO`

  -- looking glass
  k.remap_event("norg", "n", prefix .. "g", "core.looking-glass.magnify-code-block")

  -- metagen
  k.remap("norg", "n", prefix .. "m", "<Cmd>Neorg update-metadata<Cr>")
  k.remap("norg", "n", prefix .. "M", "<Cmd>Neorg inject-metadata<Cr>")

  -- all mode
  -- TODO: use hydra.nvim to enable other sub-modes

  -- telescope
  k.remap_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_link")
end

return {
  config = {
    neorg_leader = "",
    hook = hook,
  },
}
