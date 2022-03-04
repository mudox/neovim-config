url = "norcalli/nvim-colorizer.lua"

ft = { "html", "css", "javascript", "typescript", "vimscript", "swift" }

function config()
  require("colorizer").setup()
end
