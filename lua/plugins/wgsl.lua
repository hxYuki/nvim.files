vim.treesitter.language.register("wgsl", "wesl")
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "wgsl" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        wgsl_analyzer = {
          cmd = { "/home/yuki/Source/wgsl-analyzer/target/release/wgsl-analyzer" },
          filetypes = { "wgsl", "wesl" },
        },
      },
    },
  },
  -- {
  --   "wesl-link-diag",
  --   dir = "/home/yuki/Source/wesl-link-diag/editors/neovim",
  --   ft = { "wgsl" },
  --   config = function()
  --     require("wesl_link_diag").setup({
  --       executable = "wesl-link-diag",
  --     })
  --   end,
  -- },
}
