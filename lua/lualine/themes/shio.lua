-- Shio statusline, picked up by lualine's theme = "auto".
local p = vim.tbl_extend("force", {
  bg="#0D111B", panel="#141C29", raised="#1D293A", fg="#C5CBD3",
  muted="#A0ABB7", comment="#8E9489", info="#79BFE5", type="#79C2B1",
  flow="#D39ABB", warning="#E2B36D", danger="#F08080",
}, vim.g.shio_palette or {})
local function mode(accent)
  return { a={fg=p.bg,bg=accent,gui="bold"}, b={fg=accent,bg=p.raised}, c={fg=p.fg,bg=p.panel} }
end
return {
  normal=mode(p.info), insert=mode(p.type), visual=mode(p.flow),
  replace=mode(p.danger), command=mode(p.warning), terminal=mode(p.type),
  inactive={ a={fg=p.comment,bg=p.bg}, b={fg=p.comment,bg=p.bg}, c={fg=p.comment,bg=p.bg} },
}
