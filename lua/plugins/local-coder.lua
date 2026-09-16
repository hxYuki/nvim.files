-- Local FIM completion. Remove this file to restore the Copilot configuration.
return {
  { "zbirenbaum/copilot.lua", enabled = false },
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 8192, -- characters, not tokens
      debounce = 300,
      throttle = 800,
      request_timeout = 10,
      curl_extra_args = { "--noproxy", "127.0.0.1,localhost", "--connect-timeout", "1" },
      virtualtext = {
        auto_trigger_ft = { "rust", "cs", "lua", "python", "javascript", "typescript", "typescriptreact", "javascriptreact", "c", "cpp", "sh", "toml", "json" },
        keymap = { accept = "<M-l>", accept_line = "<C-l>", next = "<M-]>", prev = "<M-[>", dismiss = "<M-e>" },
      },
      provider_options = {
        openai_fim_compatible = {
          api_key = function() return "local" end,
          name = "Local Qwen Coder 3B",
          end_point = "http://127.0.0.1:8012/v1/completions",
          model = "qwen2.5-coder-3b",
          optional = {
            max_tokens = 64,
            temperature = 0.1,
            top_p = 0.9,
            stop = { "<|endoftext|>", "<|fim_prefix|>", "<|fim_suffix|>", "<|fim_middle|>", "<|file_sep|>" },
          },
          template = {
            prompt = function(before, after)
              return "<|fim_prefix|>" .. before .. "<|fim_suffix|>" .. after .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)
      require("config.local_coder_offline").setup()
      require("config.local_coder_suffix").setup()
      LazyVim.cmp.actions.ai_accept = function()
        local action = require("minuet.virtualtext").action
        if action.is_visible() then
          LazyVim.create_undo()
          action.accept()
          return true
        end
      end
    end,
  },
}
