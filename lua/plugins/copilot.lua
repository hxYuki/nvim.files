-- local cp = require("copilot.suggestion")
-- vim.keymap.set("i", "<C-l>", function()
--   require("copilot.suggestion").accept_word()
-- end, { desc = "accept_word", expr = true })

return {
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   enabled = false,
  -- },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_word = "<C-l>",
        },
      },
    },
  },
}
