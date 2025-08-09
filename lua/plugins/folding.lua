vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {
    foldKeyMaps = {
      setup = false,
    },
  }, -- needed even when using default config

  -- recommended: disable vim's auto-folding
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
