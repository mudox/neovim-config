return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  keys = {
    { ",s", K.c("LiveServerStart"), desc = "[LiveServer] Start" },
    { ",S", K.c("LiveServerStop"), desc = "[LiveServer] Stop" },
  },
  config = true,
}
