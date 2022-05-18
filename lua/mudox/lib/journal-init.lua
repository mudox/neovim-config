local files = vim.fn.expand("~/OneDrive/Neorg/home/journal/*.norg", false, true)
files = { unpack(files, #files - 9) }

local file
for i = 1, 8 do
  file = files[#files - i]

  local cmd
  if i == 1 then
    cmd = ("edit %s"):format(file)
  elseif i == 5 then
    cmd = ("botright new %s"):format(file)
  else
    cmd = ("vnew %s"):format(file)
  end

  vim.cmd(cmd)
end

file = files[#files] -- today
vim.cmd(("topleft vnew %s"):format(file))
