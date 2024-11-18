return {
  "nvim-treesitter/nvim-treesitter",
  keys = {
    { "v", desc = "Increment Selection" },
    { "V", desc = "Decrement Selection", mode = "x" },
  },
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "vv",
        node_decremental = "V",
        node_incremental = "v",
      },
    },
  },
}
