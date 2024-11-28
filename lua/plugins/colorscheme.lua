-- vim.cmd([[
-- set termguicolors
-- let g:ayucolor="dark"
-- ]])

return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "Shatur/neovim-ayu",
    name = "ayu",

    opts = {
      overrides = {
        Search = { bg = "None", fg = "#eed9ff" },
        WildMenu = { fg = "#ffffff" },
      },
    },
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-mirage",
    },
  },
}
