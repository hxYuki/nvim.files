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
      -- copilot_node_command = "/home/yuki/.nvm/versions/node/v24.6.0/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_word = "<C-l>",
        },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },
  -- {
  --   "saghen/blink.cmp",
  --   -- optional: provides snippets for the snippet source
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     "milanglacier/minuet-ai.nvim",
  --   },
  --
  --   -- use a release tag to download pre-built binaries
  --   version = "1.*",
  --   -- AND/OR build from source
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = function(_, opts)
  --     opts = opts or {}
  --
  --     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  --     -- 'super-tab' for mappings similar to vscode (tab to accept)
  --     -- 'enter' for enter to accept
  --     -- 'none' for no mappings
  --     --
  --     -- All presets have the following mappings:
  --     -- C-space: Open menu or open docs if already open
  --     -- C-n/C-p or Up/Down: Select next/previous item
  --     -- C-e: Hide menu
  --     -- C-k: Toggle signature help (if signature.enabled = true)
  --     --
  --     -- See :h blink-cmp-config-keymap for defining your own keymap
  --     opts.keymap = opts.keymap or {}
  --     opts.keymap.preset = opts.keymap.preset or "default"
  --     opts.keymap["<C-p>"] = {
  --       function(cmp)
  --         cmp.show({ providers = { "minuet" } })
  --       end,
  --     }
  --     opts.keymap["<C-l>"] = {
  --       function(cmp)
  --         local item = cmp.get_selected_item()
  --         if not item or item.source_id ~= "minuet" then
  --           return false
  --         end
  --
  --         local text = item.textEdit and item.textEdit.newText or item.insertText or item.label
  --         local next_word = vim.fn.matchstr(text, [[^\s*\%(\k\+\|.\)]])
  --         if next_word == "" or next_word == text then
  --           return cmp.accept()
  --         end
  --
  --         -- Blink accepts asynchronously, so mutate a private copy of the item.
  --         item = vim.deepcopy(item)
  --         item.insertText = next_word
  --         if item.textEdit then
  --           item.textEdit.newText = next_word
  --         end
  --         require("blink.cmp.completion.list").items[cmp.get_selected_item_idx()] = item
  --         return cmp.accept()
  --       end,
  --       "fallback",
  --     }
  --
  --     opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
  --       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = "mono",
  --     })
  --
  --     -- (Default) Only show the documentation popup when manually triggered
  --     opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
  --       documentation = { auto_show = false },
  --       trigger = { prefetch_on_insert = false },
  --     })
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     opts.sources = opts.sources or {}
  --     opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
  --     if not vim.tbl_contains(opts.sources.default, "minuet") then
  --       table.insert(opts.sources.default, "minuet")
  --     end
  --     opts.sources.providers = vim.tbl_deep_extend("force", opts.sources.providers or {}, {
  --       minuet = {
  --         name = "minuet",
  --         module = "minuet.blink",
  --         async = true,
  --         timeout_ms = 3000,
  --         score_offset = 50,
  --       },
  --     })
  --
  --     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  --     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  --     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --     --
  --     -- See the fuzzy documentation for more information
  --     opts.fuzzy = vim.tbl_deep_extend("force", opts.fuzzy or {}, {
  --       implementation = "prefer_rust_with_warning",
  --     })
  --
  --     return opts
  --   end,
  --   opts_extend = { "sources.default" },
  -- },
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   config = function()
  --     require("minuet").setup({
  --       provider = "openai_fim_compatible",
  --       provider_options = {
  --         openai_fim_compatible = {
  --           api_key = "DEEPSEEK_API_KEY",
  --           name = "deepseek",
  --           optional = {
  --             max_tokens = 256,
  --             top_p = 0.9,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
}
