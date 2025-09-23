-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.filetype.add({
  extension = {
    cs = "csharp",
  },
})
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
