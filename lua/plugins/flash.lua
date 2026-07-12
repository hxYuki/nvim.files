local function delete_selection_to_clipboard()
  vim.cmd([[normal! "+d]])
  return false
end

local function delete_selection_to_blackhole()
  vim.cmd([[normal! "_d]])
  return false
end

local function cut_selection_to_clipboard()
  vim.schedule(function()
    vim.api.nvim_feedkeys(vim.keycode([["+c]]), "n", false)
  end)
  return false
end

local function cut_selection_to_blackhole()
  vim.schedule(function()
    vim.api.nvim_feedkeys(vim.keycode([["_c]]), "n", false)
  end)
  return false
end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      false,
    },
    {
      "f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "vv",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          labels = "",
          actions = {
            ["v"] = "next",
            ["V"] = "prev",
            ["<M-c>"] = cut_selection_to_clipboard,
            ["c"] = cut_selection_to_blackhole,
            ["<M-d>"] = delete_selection_to_clipboard,
            ["d"] = delete_selection_to_blackhole,
          },
        })
      end,
      desc = "Treesitter Incremental Selection (no labels)",
    },
    {
      "vV",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["v"] = "next",
            ["V"] = "prev",
            ["<M-c>"] = cut_selection_to_clipboard,
            ["c"] = cut_selection_to_blackhole,
            ["<M-d>"] = delete_selection_to_clipboard,
            ["d"] = delete_selection_to_blackhole,
          },
        })
      end,
      desc = "Treesitter Incremental Selection",
    },
  },
}
