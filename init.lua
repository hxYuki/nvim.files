-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")

vim.filetype.add({
  extension = {
    wgsl = "wgsl",
    wesl = "wesl", -- Maps WESL to the WGSL parser
  },
})
