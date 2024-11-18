-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v" }, "y", '"*y')
map({ "n", "v" }, "Y", '"*Y')
-- map({ "n" }, "p", '"*p')
-- map({ "n" }, "<M-p>", '""p')
-- map({ "n" }, "P", '"*P')

map({ "n", "v" }, "d", '"_d')
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "<M-d>", '"*d')
map({ "n", "v" }, "<M-c>", '"*c', { remap = false })

map({ "n", "v" }, "<C-a>", "ggVG")
map({ "n", "x", "o" }, "f", function()
  require("flash").jump()
end, { desc = "Flash" })

-- map({ "v" }, "<Tab>", "<Plug>luasnip-expand-snippet")
-- --map({ "i" }, "<M-s>", "<Plug>luasnip-expand-snippet")
-- map({ "i" }, "<M-s>", function()
--   require("luasnip").expand()
-- end, { silent = true })
--
--
