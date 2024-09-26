-- stylua: ignore
local function mc() return require("multicursor-nvim") end

-- freeze or add cursor (unfreeze)
local function freeze()
  if mc().cursorsEnabled() then
    -- Stop other cursors from moving.
    -- This allows you to reposition the main cursor.
    mc().disableCursors()
  else
    mc().addCursor()
  end
end

-- unfreeze or clear cursors or <Esc>
local function exit()
  if not mc().cursorsEnabled() then
    mc().enableCursors()
  elseif mc().hasCursors() then
    mc().clearCursors()
  else
    -- Default <esc> handler.
  end
end

-- stylua: ignore
local keys =  {
  -- add cursor above/below
  { "<Up>",          function() mc().addCursor("k") end,       desc = "[MC] Add above",           mode = { "n", "v" }, },
  { "<Down>",        function() mc().addCursor("j") end,       desc = "[MC] Add below",           mode = { "n", "v" }, },
  { "<C-LeftMouse>", function() mc().handleMouse() end,        desc = "[MC] Add with mouse",      mode = { "n", "v" }, },

  { "<C-n>",         function() mc().addCursor("*") end,       desc = "[MC] Add with *",          mode = { "n", "v" }, },

  { "S",             function() mc().splitCursors() end,       desc = "[MC] Split",               mode = { "v"      }, },
  { "M",             function() mc().matchCursors() end,       desc = "[MC] Match",               mode = { "v"      }, },

  { "I",             function() mc().insertVisual() end,       desc = "[MC] Insert",              mode = { "v",     }, },
  { "A",             function() mc().appendVisual() end,       desc = "[MC] Append",              mode = { "v",     }, },
  -- skip
  { "q",             function() mc().skipCursor("*") end,      desc = "[MC] Skip with *",         mode = { "n", "v" }, },
  -- rotate
  { "<Right>",       function() mc().nextCursor() end,         desc = "[MC] Previous",            mode = { "n", "v" }, },
  { "<Left>",        function() mc().prevCursor() end,         desc = "[MC] Next",                mode = { "n", "v" }, },
  -- delete main cursor
  { "<leader>mx",    function() mc().deleteCursor() end,       desc = "[MC] Delete",              mode = { "n", "v" }, },
  -- tanspose
  { "<leader>ml",    function() mc().transposeCursors(1) end,  desc = "[MC] Transpose forwards",  mode = { "n", "v" }, },
  { "<leader>mh",    function() mc().transposeCursors(-1) end, desc = "[MC] Transpose backwards", mode = { "n", "v" }, },
  -- disable
  { "<C-q>",         freeze,                                   desc = "[MC] Disable",             mode = { "n", "v" }, },
  { "<Esc>",         exit,                                     desc = "[MC] Exit",                mode = { "n",     }, },
}

return {
  "jake-stewart/multicursor.nvim",
  keys = keys,
  opts = true,
  cond = false, -- conflicts with visual-multi
}
