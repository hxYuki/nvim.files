-- vim.cmd([[
-- set termguicolors
-- let g:ayucolor="dark"
-- ]])

return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "Shatur/neovim-ayu",
    name = "ayu",

    -- opts = function()
    --   require("nvim-treesitter.configs").setup({
    --     rainbow = {
    --       enable = true,
    --       colors = require("ayu.colors").generate(),
    --     },
    --   })
    -- end,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "ayu",
    },
  },
}
