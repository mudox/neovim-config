local m = require("telescope.pickers.layout_strategies")

-- patch `bottom_pane` layout
local org_bottom_pane = m.bottom_pane
m.bottom_pane = function(...)
  local ret = org_bottom_pane(...)
  ret.prompt.line = ret.prompt.line - 1
  return ret
end

-- patch `center` layout
local org_center = m.center
m.center = function(...)
  local ret = org_center(...)
  ret.prompt.line = ret.prompt.line - 1
  local p = ret.preview
  if p then
    p.height = p.height - 1
  end
  return ret
end
