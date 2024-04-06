local function opts()
  local i = require("mudox.ui.icon")
  local a = require("diffview.actions")

  return {
    enhanced_diff_hl = false,

    icons = {
      folder_closed = i.folder.closed,
      folder_open = i.folder.open,
    },

    signs = {
      fold_closed = i.chevron.right,
      fold_open = i.chevron.down,
    },

    -- ISSUE: defaults keymaps are all disabled, that is a lot of keymaps
    --
    -- stylua: ignore
    keymaps = {
      disable_defaults = true,
      view = {
        { "n", "<C-n>", a.select_next_entry, { desc = "Open the diff for the next file"     }},
        { "n", "<C-p>", a.select_prev_entry, { desc = "Open the diff for the previous file" }},
      },
      file_panel = {
        { "n", "<C-n>", a.select_next_entry, { desc = "Open the diff for the next file"     }},
        { "n", "<C-p>", a.select_prev_entry, { desc = "Open the diff for the previous file" }},
      },
    },
  }
end

local tabman_id = "Diff"
-- stylua: ignore
local keys = {
  { "d", function() require("mudox.lab.tabman").open(tabman_id, "DiffviewOpen") end,     desc = "[Diffview] Open",     },
  { "D", function() require("mudox.lab.tabman").recreate(tabman_id, "DiffviewOpen") end, desc = "[Diffview] Recreate", },
}

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = keys,
  opts = opts,
}
