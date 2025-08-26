-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set default intergrated shell

if vim.fn.has("win32") == 1 then
  vim.o.shell = '"C:\\Program Files\\WindowsApps\\Microsoft.PowerShell_7.5.2.0_x64__8wekyb3d8bbwe\\pwsh.exe"'
end

-- Set wrap line
vim.o.wrap = true
vim.o.showbreak = "↪"
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "shift:4,sbr"
