local patches = {
  { "snacks.nvim", "snacks_del_augroup" },
  { "edgy.nvim", "edgy_check_main" },
}

local function err(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

return function()
  On.LazySyncPre(function()
    for _, v in ipairs(patches) do
      local plugin_dir = vim.fn.stdpath("data") .. "/lazy/" .. v[1]
      local r = vim.system({ "git", "-C", plugin_dir, "restore", "." }):wait()
      if r.code ~= 0 then
        err(("error git restore %s: %s"):format(v[1], r.stderr))
      end
    end
  end, { group = V.ag.snacks })

  On.LazySync(function()
    for _, v in ipairs(patches) do
      local plugin_dir = vim.fn.stdpath("data") .. "/lazy/" .. v[1]
      local patch = vim.fn.stdpath("config") .. "/patches/" .. v[2] .. ".patch"
      local r = vim.system({ "git", "-C", plugin_dir, "apply", patch }):wait()
      if r.code ~= 0 then
        err(("error apply patch to %s: %s"):format(v[1], r.stderr))
      end
    end
  end, { group = V.ag.snacks })
end
