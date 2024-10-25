local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set("n", "<space>sh", ht.hoogle.hoogle_signature, opts)
