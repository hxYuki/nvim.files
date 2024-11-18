local ht = require("haskell-tools")
-- local bufnr = vim.api.nvim_get_current_buf()
-- local opts = { noremap = true, silent = true, buffer = bufnr }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>hl", vim.lsp.codelens.run, { desc = "Run code lenses", noremap = true, silent = true })
-- Hoogle search for the type signature of the definition under the cursor
-- vim.keymap.set(
--   "n",
--   "<space>hs",
--   ht.hoogle.hoogle_signature,
--   { desc = "Hoogle signature", noremap = true, silent = true }
-- )
-- Evaluate all code snippets
-- vim.keymap.set("n", "<space>ha", ht.lsp.buf_eval_all, { desc = "Evaluate all", noremap = true, silent = true })

return {
  "mrcjkb/haskell-tools.nvim",
  keys = {
    -- { "<space>hl>", mode = {'n'}, action = ht.lsp.codelens.run, desc = "Run code lenses" },
    { "<space>hs", mode = { "n" }, ht.hoogle.hoogle_signature, desc = "Hoogle Signature" },
    { "<space>ha", mode = { "n" }, ht.lsp.buf_eval_all, desc = "Evaluate All" },
    { "<space>hr", mode = { "n" }, ht.lsp.restart, desc = "Restart Lsp" },
  },
}
