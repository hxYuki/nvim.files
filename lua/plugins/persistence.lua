return {
  "folke/persistence.nvim",
  keys = {
    {
      "<leader>qd",
      ":lua require('persistence').stop()<CR> <BAR> :quitall<CR>",
      desc = "Quit All Without Saving Session",
    },
  },
}
