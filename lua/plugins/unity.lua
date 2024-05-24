return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_by_pattern = {
          "*.meta",
        },
      },
    },
  },
  -- config = function ()
  --     require("neo-tree").setup{
  --           filesystem = {
  --               filtered_items = {
  --                   hide_by_pattern
  --               }
  --           }
  --       }
  -- end
}
