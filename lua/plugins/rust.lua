return {
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
}
