if vim.g.vscode ~= nil then
  return {}
end

return {
  {
    "seblyng/roslyn.nvim",

    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig

    ft = "cs",
    opts = {
      -- broad_search = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "csharpier", "netcoredbg" },
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "C:\\Users\\Ixi\\AppData\\Local\\nvim-data\\mason\\bin\\csharpier.cmd",
          -- args = { "--write-stdout" },
        },
      },
    },
  },
}
