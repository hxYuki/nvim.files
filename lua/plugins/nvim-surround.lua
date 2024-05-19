return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        normal = "sa",
        normal_cur = "sas",
        normal_line = "saS",
        normal_cur_line = "sass",
        visual = "a",
        visual_line = "ga",
        delete = "sd",
        change = "sc",
        change_line = "scs",
      },
    })
  end,
}
