-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set default intergrated shell

if vim.fn.has("win32") == 1 then
  vim.o.shell = '"pwsh"'
end

-- Set wrap line
vim.o.wrap = true
vim.o.showbreak = "↪"
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.breakindentopt = "shift:4,sbr"
vim.o.mousescroll = "ver:1"
vim.o.ttimeoutlen = 150
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4
-- vim.o.expandtab = true
--
-- vim.o.autoindent = true
-- vim.o.smartindent = true
