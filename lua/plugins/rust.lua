return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              overrideCommand = {
                "cargo",
                "clippy",
                "--workspace",
                "--message-format=json",
                "--all-targets",
              },
            },
            completion = {
              callable = {
                snippets = "none",
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", "bsn_fmt" },
      },
      formatters = {
        bsn_fmt = {
          command = "bsnfmt",
          stdin = true,
        },
      },
    },
  },
}
