-- if true then
--   return {}
-- end
local fs = vim.fs
local uv = vim.uv

vim.lsp.config("roslyn", {
  cmd = {
    "D:/Exec/Roslyn/Roslyn.cmd",
    "--logLevel", -- this property is required by the server
    "Information",
    "--extensionLogDirectory", -- this property is required by the server
    fs.joinpath(uv.os_tmpdir(), "roslyn_ls/logs"),
    "--stdio",
  },
  settings = {
    ["csharp|symbol_search"] = {
      dotnet_search_reference_assemblies = true,
    },
    ["csharp|completion"] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      -- csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      -- csharp_enable_inlay_hints_for_types = true,
      -- dotnet_enable_inlay_hints_for_indexer_parameters = true,
      -- dotnet_enable_inlay_hints_for_literal_parameters = true,
      -- dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      -- dotnet_enable_inlay_hints_for_other_parameters = true,
      -- dotnet_enable_inlay_hints_for_parameters = true,
      -- dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
      -- dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
      -- dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

vim.api.nvim_create_autocmd({
  "BufEnter",
}, {
  pattern = "*.cs",
  callback = function()
    vim.lsp.enable("roslyn")
  end,
})

-- require("conform").setup({
--   formatters_by_ft = {
--     csharp = {
--       csharpier = {
--         command = "C:\\Users\\Ixi\\AppData\\Local\\nvim-data\\mason\\bin\\csharpier.cmd",
--         args = { "--write-stdout", "$FILENAME" },
--         stdin = true,
--       },
--     },
--   },
-- })

return {
  {
    "seblyng/roslyn.nvim",

    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig

    ft = "cs",
    opts = {
      -- broad_search = true,
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
}
