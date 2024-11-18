vim.keymap.set({ "n", "v" }, "s", "<nop>")

return {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delete = "sd", -- Delete surrounding
      find = "sf", -- Find surrounding (to the right)
      find_left = "sF", -- Find surrounding (to the left)
      highlight = "sh", -- Highlight surrounding
      replace = "sr", -- Replace surrounding
    },
  },
}
