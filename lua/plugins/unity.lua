return {
  {
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
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      files = {
        rg_opts = [[--color=never --files --hidden --follow -g "!.git" -g "!**/*.meta" -g "!**/*.asset" -g "!**/*.prefab"]],
      },
    },
  },
}
