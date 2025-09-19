return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      false,
    },
    {
      "f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "vv",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["v"] = "next",
            ["V"] = "prev",
          },
        })
      end,
      desc = "Treesitter Incremental Selection",
    },
  },
}
