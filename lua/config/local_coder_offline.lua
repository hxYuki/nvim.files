-- Keep an optional local model from interrupting editor completion.
local M = {}

function M.setup()
  local utils = require("minuet.utils")
  if utils._local_coder_offline_guard then return end
  utils._local_coder_offline_guard = true
  local retry_at = 0
  local offline_codes = { [7] = true, [52] = true, [56] = true }
  for _, name in ipairs({ "stream_decode", "no_stream_decode" }) do
    local decode = utils[name]
    utils[name] = function(response, data_file, provider, get_text)
      local empty_timeout = response.code == 28 and (response.stdout or "") == ""
      if provider == "Local Qwen Coder 3B" and (offline_codes[response.code] or empty_timeout) then
        os.remove(data_file)
        retry_at = vim.uv.now() + 3000
        return nil
      end
      return decode(response, data_file, provider, get_text)
    end
  end
  local backend = require("minuet.backends.openai_fim_compatible")
  local complete = backend.complete
  backend.complete = function(context, callback)
    local options = require("minuet").config.provider_options.openai_fim_compatible
    if options.name == "Local Qwen Coder 3B" and vim.uv.now() < retry_at then
      callback({})
      return
    end
    return complete(context, callback)
  end
end

return M
