local function setup_keymaps(bufnr) end

local function init()
  U.on("BufRead", {
    pattern = "Cargo.toml",
    callback = function(event)
      require("lazy").load("crates.nvim")

      cmp.setup.buffer {
        sources = {
          { name = "crates" },
          { name = "path", keyword_length = 3 },
          { name = "buffer", keyword_length = 4 },
        },
      }

      return true
    end,
  })
end

local function config()
  require("crates").setup {
    src = {
      cmp = {
        enabled = true,
      },
    },
    -- code actions
    null_ls = {
      enabled = true,
      name = "Crates",
    },
  }
end

return {
  "saecki/crates.nvim",
  tag = "v0.4.0",
  dependencies = { "plenary.nvim", "nvim-cmp", "none-ls.nvim" },
  init = init,
  config = config,
}
