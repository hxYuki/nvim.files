local ht = require("haskell-tools")
-- local bufnr = vim.api.nvim_get_current_buf()
-- local opts = { noremap = true, silent = true, buffer = bufnr }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>hl", vim.lsp.codelens.run, { desc = "Run code lenses", noremap = true, silent = true })

return {
  "mrcjkb/haskell-tools.nvim",
  ft = "haskell",
  keys = {
    -- { "<space>hl>", mode = {'n'}, action = ht.lsp.codelens.run, desc = "Run code lenses" },
    { "<space>hs", mode = { "n" }, ht.hoogle.hoogle_signature, desc = "Hoogle Signature" },
    { "<space>ha", mode = { "n" }, ht.lsp.buf_eval_all, desc = "Evaluate All" },
    { "<space>hr", mode = { "n" }, ht.lsp.restart, desc = "Restart Lsp" },
    { "<space>hp", mode = { "n" }, ":HsProjectCabal<CR>", desc = "Open Cabal file" },
  },
}
