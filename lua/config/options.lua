-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.shell = "powershell.exe"
-- opt.shellcmdflag = '-command'
-- opt.shellquote = '\"'
opt.guifont = "CaskaydiaCove Nerd Font:h12"

opt.tabstop = 4
opt.shiftwidth = 4
opt.encoding = "utf-8"

opt.clipboard = ""

vim.commentstring = "//%s"
