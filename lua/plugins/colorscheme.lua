vim.cmd([[
set termguicolors
let g:ayucolor="dark"
]])

return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "Luxed/ayu-vim",
    name = "ayu",

    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
