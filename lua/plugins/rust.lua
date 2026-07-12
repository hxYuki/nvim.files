return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      server = {
        cmd_env = {
          PATH = "/home/yuki/.local/bin:" .. (vim.env.PATH or ""),
          CARGO_TARGET_TMPFS_FORCE = "1",
        },
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraEnv = {
                PATH = "/home/yuki/.local/bin:" .. (vim.env.PATH or ""),
                CARGO_TARGET_TMPFS_FORCE = "1",
              },
              buildScripts = {
                overrideCommand = {
                  "/home/yuki/.local/bin/cargo",
                  "check",
                  "--quiet",
                  "--workspace",
                  "--message-format=json",
                  "--all-targets",
                  "--keep-going",
                },
              },
            },
            check = {
              extraEnv = {
                PATH = "/home/yuki/.local/bin:" .. (vim.env.PATH or ""),
                CARGO_TARGET_TMPFS_FORCE = "1",
              },
              overrideCommand = {
                "/home/yuki/.local/bin/cargo",
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
