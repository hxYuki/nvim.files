local M = {}

local setup_done = false
local unpack_values = table.unpack or unpack

local function pack(...)
  return { n = select("#", ...), ... }
end

---@param workspace_edit lsp.WorkspaceEdit
---@return table<string, { uri: string, force: boolean, changedtick: integer? }>
local function edited_files(workspace_edit)
  local created = {}
  local files = {}

  for _, change in ipairs(workspace_edit.documentChanges or {}) do
    if change.kind == "create" then
      local path = vim.uri_to_fname(change.uri)
      -- A CreateFile operation creates an empty file before its TextDocumentEdit
      -- is applied. If Neovim already knew the path as a new buffer, only
      -- :write! can replace that empty file.
      created[path] = vim.uv.fs_stat(path) == nil
    end
  end

  for _, change in ipairs(workspace_edit.documentChanges or {}) do
    if not change.kind and change.textDocument then
      local uri = change.textDocument.uri
      local path = vim.uri_to_fname(uri)
      files[path] = { uri = uri, force = created[path] == true }
    end
  end

  for uri in pairs(workspace_edit.changes or {}) do
    local path = vim.uri_to_fname(uri)
    files[path] = { uri = uri, force = false }
  end

  for path, file in pairs(files) do
    local bufnr = vim.fn.bufnr(path)
    if bufnr >= 0 and vim.api.nvim_buf_is_loaded(bufnr) then
      file.changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
    end
  end

  return files
end

---@param files table<string, { uri: string, force: boolean, changedtick: integer? }>
local function save_files(files)
  for _, file in pairs(files) do
    local bufnr = vim.uri_to_bufnr(file.uri)
    if
      vim.api.nvim_buf_is_loaded(bufnr)
      and vim.bo[bufnr].buftype == ""
      and vim.bo[bufnr].modified
      and (
        file.changedtick == nil
        or file.changedtick ~= vim.api.nvim_buf_get_changedtick(bufnr)
      )
    then
      local ok, err = pcall(vim.api.nvim_buf_call, bufnr, function()
        vim.cmd({
          cmd = "write",
          bang = file.force,
          mods = { keepalt = true, silent = true },
        })
      end)
      if not ok then
        vim.notify(
          ("Failed to save LSP workspace edit for %s:\n%s"):format(vim.api.nvim_buf_get_name(bufnr), err),
          vim.log.levels.ERROR
        )
      end
    end
  end
end

function M.setup()
  if setup_done then
    return
  end
  setup_done = true

  local original_apply_workspace_edit = vim.lsp.util.apply_workspace_edit
  vim.lsp.util.apply_workspace_edit = function(workspace_edit, position_encoding)
    local files = edited_files(workspace_edit)
    local results = pack(original_apply_workspace_edit(workspace_edit, position_encoding))
    save_files(files)
    return unpack_values(results, 1, results.n)
  end
end

return M
