vim.opt.runtimepath:prepend(vim.fn.getcwd())
require("config.lsp_workspace_edit").setup()

local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")

local function read(path)
  return table.concat(vim.fn.readfile(path), "\n")
end

local function assert_equal(expected, actual, label)
  assert(expected == actual, ("%s: expected %q, got %q"):format(label, expected, actual))
end

local existing = root .. "/existing.txt"
vim.fn.writefile({ "before" }, existing)
local existing_uri = vim.uri_from_fname(existing)
vim.lsp.util.apply_workspace_edit({
  changes = {
    [existing_uri] = {
      {
        range = {
          start = { line = 0, character = 0 },
          ["end"] = { line = 0, character = 6 },
        },
        newText = "after",
      },
    },
  },
}, "utf-8")
local existing_buf = vim.uri_to_bufnr(existing_uri)
assert_equal("after", read(existing), "existing file was auto-saved")
assert_equal(false, vim.bo[existing_buf].modified, "existing buffer was marked saved")

local created = root .. "/created.txt"
local created_uri = vim.uri_from_fname(created)
local created_buf = vim.uri_to_bufnr(created_uri)
vim.fn.bufload(created_buf)
vim.lsp.util.apply_workspace_edit({
  documentChanges = {
    { kind = "create", uri = created_uri },
    {
      textDocument = { uri = created_uri, version = vim.NIL },
      edits = {
        {
          range = {
            start = { line = 0, character = 0 },
            ["end"] = { line = 0, character = 0 },
          },
          newText = "generated",
        },
      },
    },
  },
}, "utf-8")
assert_equal("generated", read(created), "created file was force-written over the empty file")
assert_equal(false, vim.bo[created_buf].modified, "created buffer was marked saved")

local unrelated = root .. "/unrelated.txt"
vim.fn.writefile({ "disk" }, unrelated)
local unrelated_buf = vim.fn.bufadd(unrelated)
vim.fn.bufload(unrelated_buf)
vim.api.nvim_buf_set_lines(unrelated_buf, 0, -1, false, { "unsaved" })

vim.lsp.util.apply_workspace_edit({
  changes = {
    [existing_uri] = {
      {
        range = {
          start = { line = 0, character = 0 },
          ["end"] = { line = 0, character = 5 },
        },
        newText = "again",
      },
    },
  },
}, "utf-8")
assert_equal("disk", read(unrelated), "unrelated buffer was not written")
assert_equal(true, vim.bo[unrelated_buf].modified, "unrelated buffer remains modified")

vim.fn.delete(root, "rf")
print("ok: LSP workspace edits auto-save only their affected files")
