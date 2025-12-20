local function err(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

return function()
  local snacks_dir = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"

  On.LazySyncPre(function()
    print("git restore snacks.nvim")
    local r = vim.system({ "git", "-C", snacks_dir, "restore", "." }):wait()
    if r.code ~= 0 then
      err("error git restore snacks.nvim: " .. r.stderr)
    end
  end, { group = V.ag.snacks })

  On.LazySync(function()
    print("git apply snacks.nvim")
    local patch = vim.fn.stdpath("config") .. "/patches/snacks_del_augroup.patch"
    local r = vim.system({ "git", "-C", snacks_dir, "apply", patch }):wait()
    if r.code ~= 0 then
      err("error git apply snacks.nvim: " .. r.stderr)
    end
  end, { group = V.ag.snacks })
end
