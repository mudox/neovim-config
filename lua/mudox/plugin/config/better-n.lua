local mappings = {
  ["#"] = { previous = "n", next = "<s-n>" },
  ["F"] = { previous = ";", next = "," },
  ["T"] = { previous = ";", next = "," },
}

local suffixes = { "b", "g", "d", "m" }
for _, s in ipairs(suffixes) do
  mappings["]" .. s] = { previous = "[" .. s, next = "]" .. s }
  mappings["[" .. s] = { previous = "[" .. s, next = "]" .. s }
end

local function mapping_executed(mode, key)
  print(("[Better-N]: perform <%s>"):format(key))
end

require("better-n").setup {
  callbacks = {
    mapping_executed = mapping_executed,
  },
  mappings = mappings,
}

vim.keymap.set("n", "n", require("better-n").n, { nowait = true })
vim.keymap.set("n", "<S-n>", require("better-n").shift_n, { nowait = true })
