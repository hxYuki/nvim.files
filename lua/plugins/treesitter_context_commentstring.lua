-- require("ts_context_commentstring").setup({
--   enable_autocmd = false,
--   config = {
--     languages = {
--       csharp = "// %s",
--       fsharp = "// %s",
--     },
--   },
--   languages = {
--     csharp = "// %s",
--     fsharp = "// %s",
--   },
--   commentary_integration = {},
-- })

return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  lazy = true,
  opts = {
    enable_autocmd = false,
    languages = {
      c_sharp = { __default = "// %s", __multiline = "/* %s */" },
      -- fsharp not available for lack of ts_parser
      fsharp = { __default = "// %s", __multiline = "(* %s *)" },
    },
  },
  init = function()
    if vim.fn.has("nvim-0.10") == 1 then
      vim.schedule(function()
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
          return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
            or get_option(filetype, option)
        end
      end)
    end
  end,
}
