-- vim.cmd([[
-- set termguicolors
-- let g:ayucolor="dark"
-- ]])

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          Function = { fg = "#96d1ff" },
          -- Operator = { fg = colors.blue },
          ["@parameter"] = { fg = "#caacc2" },
          ["@variable.parameter"] = { fg = "#caacc2" },
          -- ["@tag.attribute"] = { fg =  },
          Type = { fg = "#d8c59e" },
          -- Class = { fg = colors.pink },
          ["@lsp.type.struct"] = { fg = "#84b6ae" },
        }
      end,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        float = "transparent",
      },
      overrides = function(colors)
        return {
          StatusLine = { bg = colors.palette.sumiInk4 }, -- why this is Ink4 ? it should be Ink2
          ["@lsp.type.interface"] = { fg = "#97b997" },
          ["@lsp.type.struct"] = { fg = "#77a7ac" },
          ["@module"] = { fg = "#829596" },
          Visual = { bg = "#59516c" },
        }
      end,
    },
  },
  {
    "Shatur/neovim-ayu",
    name = "ayu",

    opts = function(_, opts)
      opts.overrides = {
        Normal = { bg = "None" },
        ColorColumn = { bg = "None" },
        SignColumn = { bg = "None" },
        Folded = { bg = "None" },
        FoldColumn = { bg = "None" },
        CursorLine = { bg = "None" },
        CursorColumn = { bg = "None" },
        WhichKeyFloat = { bg = "None" },
        VertSplit = { bg = "None" },

        Search = { bg = "None", fg = "#eed9ff" },
        WildMenu = { fg = "#ffffff" },
      }
    end,

    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
