local M = {}

function M.setup()
  require("mini.align").setup {
    mappings = {
      start = "gA",
      start_with_preview = "ga",
    },

    modifiers = {
      J = function(_, opts)
        local next_option = ({
          left = "center",
          center = "right",
          right = "none",
          none = "left",
        })[opts.justify_side]
        opts.justify_side = next_option or "left"
      end,
    },

    silent = true,
  }
end

return M
