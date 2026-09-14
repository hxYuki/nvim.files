-- Qwen FIM sometimes continues through existing code. Only return new text;
-- never replace or delete the buffer's suffix to accommodate a suggestion.
local M = {}

-- Parse only the parameter list, so nested tuples, fn pointers, comments and
-- strings keep their own parentheses. Missing/invalid syntax is not guessed.
local function rust_parameters(text)
  local source = "fn __local" .. text
  local ok, parser = pcall(vim.treesitter.get_string_parser, source, "rust")
  if not ok then return nil end
  local trees = parser:parse()
  local function find(node)
    local _, _, start_byte = node:start()
    if node:type() == "parameters" and start_byte == #"fn __local" then
      local value = vim.treesitter.get_node_text(node, source)
      if not node:has_error() and value:sub(-1) == ")" then
        return value:sub(2, -2)
      end
      return nil
    end
    for child in node:iter_children() do
      local value = find(child)
      if value ~= nil then return value end
    end
  end
  return trees[1] and find(trees[1]:root())
end

local function empty_rust_parameters(before, after, filetype)
  return filetype == "rust" and after:match("^%s*%)") and
    (before:match("%f[%w]fn%s+[%w_]+%s*%(%s*$") or
      before:match("%f[%w]fn%s+[%w_]+%b<>%s*%(%s*$"))
end

function M.trim(text, after, before, filetype)
  if type(text) ~= "string" or type(after) ~= "string" or after == "" then
    return text
  end

  if type(before) == "string" and empty_rust_parameters(before, after, filetype) then
    -- Prefer treating the candidate as new contents; this preserves a tuple
    -- pattern such as (x, y): (i32, i32). Only then try a repeated whole list.
    return rust_parameters("(" .. text .. ") {}") or rust_parameters(text)
  end

  -- A complete, nontrivial suffix line is a reliable boundary, even when the
  -- model continues generating after it. Match literally (not Lua patterns).
  local offset = 1
  local anchor
  for line in (after .. "\n"):gmatch("([^\n]*)\n") do
    if line:find("%S") then
      anchor = line
      break
    end
    offset = offset + #line + 1
  end
  if anchor and #anchor:gsub("%s", "") >= 3 and anchor:find("[%w_]") then
    local boundary = after:sub(1, offset + #anchor - 1)
    local start = text:find(boundary, 1, true)
    if start then
      return text:sub(1, start - 1)
    end
  end

  -- Handle a candidate ending partway into the suffix. Avoid punctuation-only
  -- overlap: nested calls/brackets can legitimately require identical closers.
  for length = math.min(#text, #after), 3, -1 do
    local overlap = after:sub(1, length)
    if text:sub(-length) == overlap and overlap:find("[%w_]") then
      -- Do not split the middle of an identifier (foo + bar is not an overlap).
      local next_char = after:sub(length + 1, length + 1)
      if not (overlap:sub(-1):match("[%w_]") and next_char:match("[%w_]")) then
        return text:sub(1, #text - length)
      end
    end
  end

  -- On an occupied line, unmatched multiline continuations are ambiguous.
  -- A missing suggestion is preferable to inserting a second copy of the file.
  local right = after:match("^[^\n]*") or ""
  if right:find("%S") and text:find("\n", 1, true) then
    return nil
  end
  return text
end

function M.setup()
  local backend = require("minuet.backends.openai_fim_compatible")
  if backend._local_coder_suffix_guard then return end
  backend._local_coder_suffix_guard = true
  local complete = backend.complete
  backend.complete = function(context, callback)
    local options = require("minuet").config.provider_options.openai_fim_compatible
    if options.name ~= "Local Qwen Coder 3B" then
      return complete(context, callback)
    end
    -- A response belongs to the buffer revision and insertion point that
    -- requested it, not wherever the user has moved/typed while it was running.
    local buf = vim.api.nvim_get_current_buf()
    local tick = vim.api.nvim_buf_get_changedtick(buf)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local mode = vim.fn.mode():sub(1, 1)
    local filetype = vim.bo[buf].filetype
    return complete(context, function(items)
      if not vim.api.nvim_buf_is_valid(buf) or vim.api.nvim_get_current_buf() ~= buf
        or vim.api.nvim_buf_get_changedtick(buf) ~= tick
        or not vim.deep_equal(vim.api.nvim_win_get_cursor(0), cursor)
        or vim.fn.mode():sub(1, 1) ~= mode then
        callback({})
        return
      end
      local filtered = {}
      for _, item in ipairs(items or {}) do
        local text = M.trim(item, context.lines_after, context.lines_before, filetype)
        if text and text:find("%S") then filtered[#filtered + 1] = text end
      end
      callback(filtered)
    end)
  end
end

return M
