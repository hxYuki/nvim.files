-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set default intergrated shell

if vim.fn.has("win32") == 1 then
  vim.o.shell = '"c:\\program files\\powershell\\7\\pwsh.exe"'
end
