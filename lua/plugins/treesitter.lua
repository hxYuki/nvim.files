return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },
  -- keys = {
  --   { "v", desc = "Increment Selection" },
  --   { "V", desc = "Decrement Selection", mode = "x" },
  -- },
  opts = function(_, opts)
    -- opts.incremental_selection = {
    --   enable = true,
    --   keymaps = {
    --     init_selection = "vv",
    --     node_decremental = "V",
    --     node_incremental = "v",
    --   },
    -- }
    opts.rainbow = {
      enable = true,
      query = "rainbow-delimiters",
      strategy = require("rainbow-delimiters").strategy.global,
    }
  end,
}
