return {
  "nvim-mini/mini.surround",
  keys = {
    {
      "sd",
      "<Esc>sd",
      mode = "x",
      remap = true,
      desc = "删除包围符",
    },
    {
      "sr",
      "<Esc>sr",
      mode = "x",
      remap = true,
      desc = "替换包围符",
    },
  },
  opts = {
    n_lines = 100,
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delele = "sd", -- Delete surrounding
      replace = "sr", -- Replace surrounding
      find = "sf", -- Find surrounding (to the right)
      find_left = "sF", -- Find surrounding (to the left)
      highlight = "sh", -- Highlight surrounding
      update_n_lines = "ssn",
    },
  },
}
