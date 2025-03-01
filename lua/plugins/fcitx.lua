if vim.fn.has("win32") == 1 then
  return {}
else
  return {
    "h-hg/fcitx.nvim",
  }
end
