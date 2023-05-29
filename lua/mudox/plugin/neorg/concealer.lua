local function levelled_icons(icon)
  local t = {}
  for i = 1, 6 do
    t[("level_%d"):format(i)] = {
      icon = (" "):rep(i - 1) .. icon,
    }
  end
  return t
end

-- stylua: ignore start

local heading    = {
  level_1        = { icon = " ", },
  level_2        = { icon = "  ", },
  level_3        = { icon = "   ", },
  level_4        = { icon = "    ", },
  level_5        = { icon = "     ", },
  level_6        = { icon = "      ", },
}

local todo       = {
  done           = { icon = "" },
  undone         = { icon = " " },
  pending        = { icon = "" },
  uncertain      = { icon = "" },
  on_hold        = { icon = "" },
  cancelled      = { icon = "" },
  recurring      = { icon = "" },
  important      = { icon = "" },
  urgent         = { icon = "" },
}

local definition = {
  single         = { icon = " ", },
  multi_prefix   = { icon = " ", },
  multi_suffix   = { icon = "❞ ", },
}

local footnote   = {
  single         = { icon = "❛", },
  multi_prefix   = { icon = "❝ ", },
  multi_suffix   = { icon = "❞ ", },
}

local icons      = {
  link           = levelled_icons("➠ "),
  list           = levelled_icons("◆"),
  quote          = levelled_icons("┃"),
  heading        = heading,
  todo           = todo,
  marker         = { icon = "" },
  footnote       = footnote,
  definition     = definition,
}

-- stylua: ignore end

return {
  config = {
    icons = icons,
    folds = false,
  },
}
