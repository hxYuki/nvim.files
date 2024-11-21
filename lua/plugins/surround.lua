vim.keymap.set({ "n", "v" }, "s", "<nop>")

return {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "ssa", -- Add surrounding in Normal and Visual modes
      delele = "ssd", -- Delete surrounding
      find = "ssf", -- Find surrounding (to the right)
      find_left = "ssF", -- Find surrounding (to the left)
      highlight = "ssh", -- Highlight surrounding
      replace = "ssr", -- Replace surrounding
      update_n_lines = "ssn",
    },
  },
}
