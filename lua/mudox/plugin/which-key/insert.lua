-- TODO: insert mode keymaps

-- stylua: ignore
local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

-- stylua: ignore
return {
  ['ti'] = { c "Telescope symbols", "[Telescope] Symbols" },
}
