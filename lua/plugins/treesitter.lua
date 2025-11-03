return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    vscode = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    vscode = true,
    -- keys = {
    --   { "v", desc = "Increment Selection" },
    --   { "V", desc = "Decrement Selection", mode = "x" },
    -- },
    opts = function(_, opts)
      opts.rainbow = {
        enable = true,
        query = "rainbow-delimiters",
        strategy = require("rainbow-delimiters").strategy.global,
      }
    end,
  },
}
