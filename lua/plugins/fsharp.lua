---@class parser_configs
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.fsharp = {
  install_info = {
    url = "https://github.com/ionide/tree-sitter-fsharp",
    branch = "main",
    files = { "src/scanner.c", "src/parser.c" },
  },
  requires_generate_from_grammar = false,
  filetype = "fsharp",
}

vim.cmd([[
let g:fsharp#fsi_keymap = "custom"
let g:fsharp#fsi_keymap_send = "<C-e>"
let g:fsharp#fsi_keymap_toggle = "<C-`>"
]])

return {
  {
    "ionide/Ionide-vim",
  },
}
