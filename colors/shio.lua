-- Shio / 汐 — a quiet, readable dark theme with Rust semantic highlighting.
-- Standalone: :luafile /path/to/colors/shio.lua
-- Rust styles follow the project VS Code settings below.
-- vim.g.shio_palette controls base UI; project Rust overrides are exact.
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "shio"

local p = vim.tbl_extend("force", {
  bg = "#0D111B", panel = "#141C29", raised = "#1D293A",
  cursorline = "#161F2D", selection = "#30435B", border = "#4B617A",
  fg = "#C5CBD3", muted = "#A0ABB7", comment = "#8E9489",
  gutter = "#687583", guide = "#35404C", punct = "#9DA5AE",
  declaration = "#AE9BD3", flow = "#D39ABB",
  type = "#79C2B1", field = "#86B9D2", parameter = "#C7C5BD",
  func = "#D9B57C", macro = "#D0A080", string = "#A8C685",
  constant = "#C2A0DC", lifetime = "#CBA477",
  danger = "#F08080", warning = "#E2B36D", info = "#79BFE5", hint = "#B3A0D2",
  error_bg = "#291B26", warn_bg = "#29231D", info_bg = "#152535", hint_bg = "#221F32",
  add = "#99B88F", change = "#8CAEC2", delete = "#CC8D8D",
  diff_add = "#29382F", diff_change = "#293542",
  diff_delete = "#402D34", diff_text = "#3B4A59",
}, vim.g.shio_palette or {})

local function set(name, spec) vim.api.nvim_set_hl(0, name, spec) end
local function link(name, target) set(name, { link = target }) end
local function group(names, spec)
  for name in names:gmatch("%S+") do set(name, spec) end
end

group("Normal NormalNC", { fg = p.fg, bg = p.bg })
group("NormalFloat Pmenu", { fg = p.fg, bg = p.panel })
group("FloatBorder FloatTitle", { fg = p.muted, bg = p.panel })
group("SignColumn FoldColumn", { fg = p.gutter, bg = p.bg })
set("LineNr", { fg = p.gutter })
set("CursorLineNr", { fg = p.func })
group("CursorLine CursorColumn ColorColumn", { bg = p.cursorline })
set("Cursor", { fg = p.bg, bg = p.fg })
link("lCursor", "Cursor")
set("TermCursor", { reverse = true })
group("NonText Whitespace EndOfBuffer", { fg = p.guide })
group("WinSeparator VertSplit", { fg = p.border })
set("Folded", { fg = p.comment, bg = p.cursorline })
group("Visual VisualNOS", { bg = p.selection })
set("Search", { fg = p.fg, bg = p.selection, underline = true })
group("IncSearch CurSearch", { fg = p.bg, bg = p.func })
set("Substitute", { fg = p.bg, bg = p.danger })
set("MatchParen", { bg = p.selection, underline = true })
group("StatusLine TabLineSel WinBar", { fg = p.fg, bg = p.raised })
group("StatusLineNC TabLine TabLineFill WinBarNC", { fg = p.comment, bg = p.panel })
set("PmenuSel", { bg = p.selection })
group("PmenuMatch PmenuMatchSel", { fg = p.func, bold = true })
set("PmenuSbar", { bg = p.raised })
set("PmenuThumb", { bg = p.border })
group("PmenuExtra PmenuKind", { fg = p.muted })
group("PmenuExtraSel PmenuKindSel", { fg = p.fg, bg = p.selection })
group("Title Directory MoreMsg Question", { fg = p.type })
group("ModeMsg MsgArea", { fg = p.fg })
set("ErrorMsg", { fg = p.danger })
set("WarningMsg", { fg = p.warning })
set("WildMenu", { fg = p.fg, bg = p.selection })
set("Conceal", { fg = p.comment })
set("QuickFixLine", { bg = p.selection })

group("Comment @comment @comment.documentation", { fg = p.comment })
group("Identifier @variable", { fg = p.fg })
group("Function @function @function.call @function.method @function.method.call @function.builtin", { fg = p.func })
group("Type @type @type.builtin @type.definition @constructor", { fg = p.type })
group("String Character @string @character", { fg = p.string })
group("Constant Number Boolean Float @constant @constant.builtin @number @number.float @boolean", { fg = p.constant })
group("Keyword StorageClass Structure Typedef PreProc Include Define @keyword @keyword.function @keyword.type @keyword.modifier @keyword.import", { fg = p.declaration })
group("Statement Conditional Repeat Exception @keyword.conditional @keyword.repeat @keyword.return @keyword.exception @keyword.coroutine", { fg = p.flow })
group("Operator Delimiter @operator @punctuation @punctuation.bracket @punctuation.delimiter @punctuation.special", { fg = p.punct })
group("Macro PreCondit @function.macro", { fg = p.macro })
group("Special SpecialChar @string.escape @string.special @string.special.symbol", { fg = p.func })
group("Label @label", { fg = p.lifetime })
group("@variable.member @property", { fg = p.field })
group("@variable.parameter @variable.builtin", { fg = p.parameter })
group("@module @module.builtin", { fg = p.muted })
set("@attribute", { fg = p.macro })
set("Error", { fg = p.danger })
set("Todo", { fg = p.func, bold = true })
group("@comment.todo @comment.note", { fg = p.func, bold = true })
group("@comment.error @comment.warning", { fg = p.danger, bold = true })
set("Underlined", { underline = true })
set("Ignore", { fg = p.comment })

-- Keep standard LSP names useful for other filetypes, too.
local types = {
  variable = "@variable", parameter = "@variable.parameter", property = "@variable.member",
  namespace = "@module", type = "@type", class = "@type", struct = "@type", enum = "@type",
  interface = "ShioTrait", typeParameter = "ShioTypeParameter", enumMember = "@constant",
  function_ = "@function", method = "@function.method", macro = "@function.macro",
  decorator = "@attribute", string = "@string", number = "@number", regexp = "@string",
}
set("ShioDerive", { fg = p.type })
set("ShioTrait", { fg = p.type, italic = true })
set("ShioTypeParameter", { fg = p.type, italic = true })
for kind, target in pairs(types) do
  if kind == "function_" then kind = "function" end
  link("@lsp.type." .. kind, target)
end
-- Do not let generic LSP tokens erase Tree-sitter's keyword and escape detail.
group("@lsp.type.keyword @lsp.type.comment @lsp.type.operator", {})
set("@lsp.mod.deprecated", { strikethrough = true })

-- rust-analyzer also emits non-standard types. Clear broad modifiers so a
-- default library, readonly, static, or declaration tag does not recolor them.
for _, modifier in ipairs({
  "associated", "async", "attribute", "callable", "constant", "consuming", "controlFlow",
  "crateRoot", "declaration", "defaultLibrary", "definition", "documentation",
  "injected", "intraDocLink", "library", "macro", "modification", "mutable",
  "procMacro", "public", "readonly", "reference", "static", "trait", "unsafe",
}) do set("@lsp.mod." .. modifier .. ".rust", {}) end
local rust_types = {
  boolean = "@boolean", character = "@character", builtinType = "@type.builtin",
  typeAlias = "@type", selfTypeKeyword = "@type", union = "@type",
  trait = "ShioTrait", lifetime = "@label", constParameter = "@constant",
  const = "@constant", static = "@constant", procMacro = "@function.macro",
  selfKeyword = "@variable.builtin", escapeSequence = "@string.escape",
  formatSpecifier = "@string.special", attribute = "@attribute",
  builtinAttribute = "@attribute", derive = "ShioDerive", deriveHelper = "@attribute",
  toolModule = "@module", macroBang = "@function.macro",
  arithmetic = "@operator", bitwise = "@operator", comparison = "@operator",
  logical = "@operator", negation = "@operator", punctuation = "@punctuation", angle = "@punctuation.bracket",
  brace = "@punctuation.bracket", bracket = "@punctuation.bracket",
  parenthesis = "@punctuation.bracket", colon = "@punctuation.delimiter",
  comma = "@punctuation.delimiter", dot = "@punctuation.delimiter",
  semi = "@punctuation.delimiter", semicolon = "@punctuation.delimiter",
  attributeBracket = "@punctuation.bracket", invalidEscapeSequence = "Error",
}
for kind, target in pairs(rust_types) do link("@lsp.type." .. kind .. ".rust", target) end
group("@lsp.type.unresolvedReference.rust @lsp.type.generic.rust", {})
-- Support both variable + constant and newer const/static token types.
-- readonly alone is NOT a Rust const.
group("@lsp.typemod.variable.constant.rust @lsp.typemod.variable.static.rust", { fg = p.constant })
group("@lsp.typemod.keyword.controlFlow.rust @lsp.typemod.operator.controlFlow.rust", { fg = p.flow })
-- Mutable is a binding/receiver capability, not proof that this occurrence writes.
local mutable_style = vim.g.shio_mutable_underline and { underline = true } or { italic = true }
for _, kind in ipairs({ "variable", "static", "parameter", "selfKeyword", "property", "function", "method" }) do
  set("@lsp.typemod." .. kind .. ".mutable.rust", mutable_style)
end
-- Keep a function's gold and a variable's neutral foreground under unsafe.
set("@lsp.mod.unsafe.rust", { undercurl = true, sp = p.warning })
set("@lsp.typemod.keyword.unsafe.rust", { fg = p.warning })
set("@lsp.mod.deprecated.rust", { strikethrough = true })

-- Restrained diagnostics: bright colors occur in small marks and text only.
for severity, color in pairs({ Error = p.danger, Warn = p.warning, Info = p.info, Hint = p.hint, Ok = p.add }) do
  set("Diagnostic" .. severity, { fg = color })
  group("DiagnosticSign" .. severity .. " DiagnosticFloating" .. severity, { fg = color })
  local backdrops = { Error = p.error_bg, Warn = p.warn_bg, Info = p.info_bg, Hint = p.hint_bg }
  set("DiagnosticVirtualText" .. severity, { fg = color, bg = backdrops[severity] })
  set("DiagnosticVirtualLines" .. severity, { fg = color })
  set("DiagnosticUnderline" .. severity, { undercurl = true, sp = color })
end
set("DiagnosticUnnecessary", { fg = p.comment })
set("DiagnosticDeprecated", { strikethrough = true })
group("LspInlayHint LspCodeLens LspCodeLensSeparator", { fg = p.comment })
group("LspReferenceText LspReferenceRead LspReferenceWrite", { bg = p.raised })
set("LspSignatureActiveParameter", { fg = p.func, bg = p.raised, underline = true })
for _, name in ipairs({ "SpellBad", "SpellCap", "SpellRare", "SpellLocal" }) do
  set(name, { undercurl = true, sp = name == "SpellBad" and p.danger or p.info })
end
set("DiffAdd", { bg = p.diff_add })
set("DiffChange", { bg = p.diff_change })
set("DiffDelete", { fg = p.delete, bg = p.diff_delete })
set("DiffText", { bg = p.diff_text })
for kind, color in pairs({ Add = p.add, Change = p.change, Delete = p.delete }) do
  set("GitSigns" .. kind, { fg = color })
end
group("Added diffAdded", { fg = p.add })
group("Changed diffChanged", { fg = p.change })
group("Removed diffRemoved", { fg = p.delete })

-- Common LazyVim surfaces inherit the same visual hierarchy.
group("BlinkCmpMenu BlinkCmpDoc SnacksPickerNormal TelescopeNormal", { fg = p.fg, bg = p.panel })
group("BlinkCmpMenuBorder BlinkCmpDocBorder SnacksPickerBorder TelescopeBorder", { fg = p.border, bg = p.panel })
group("BlinkCmpMenuSelection SnacksPickerListCursorLine TelescopeSelection", { bg = p.selection })
group("BlinkCmpLabelMatch SnacksPickerMatch TelescopeMatching", { fg = p.func, bold = true })
group("BlinkCmpGhostText CopilotSuggestion MinuetVirtualText", { fg = p.comment, italic = true })
group("BlinkCmpLabelDescription BlinkCmpLabelDetail", { fg = p.comment })
group("SnacksIndent IblIndent", { fg = p.guide })
group("SnacksIndentScope IblScope", { fg = p.border })
set("WhichKey", { fg = p.func })
set("WhichKeyGroup", { fg = p.type })
set("FlashLabel", { fg = p.bg, bg = p.func, bold = true })
set("FlashBackdrop", { fg = p.comment })
set("@markup.heading", { fg = p.type, bold = true })
set("@markup.raw", { fg = p.string })
set("@markup.link", { fg = p.info, underline = true })
set("@markup.strong", { bold = true })
set("@markup.italic", { italic = true })
set("@markup.strikethrough", { strikethrough = true })

local terminal = { p.panel, p.delete, p.add, p.func, p.info, p.constant, p.type, p.fg,
  p.gutter, p.danger, p.string, p.warning, p.field, p.flow, p.type, p.fg }
for i, color in ipairs(terminal) do vim.g["terminal_color_" .. (i - 1)] = color end

-- UI surfaces: cool blues keep focus indicators apart from diagnostics.
set("FloatTitle", { fg = p.info, bg = p.panel, bold = true })
set("FloatFooter", { fg = p.muted, bg = p.panel })
set("WinSeparator", { fg = p.border, bg = p.bg })
set("PmenuSel", { fg = p.fg, bg = p.selection })
set("PmenuBorder", { fg = p.border, bg = p.panel })
set("PmenuShadow", { bg = p.bg, blend = 20 })
set("ComplMatchIns", { fg = p.type })
set("TabLineSel", { fg = p.info, bg = p.raised, bold = true })
set("WinBar", { fg = p.muted, bg = p.bg })
set("WinBarNC", { fg = p.comment, bg = p.bg })
set("CursorLineNr", { fg = p.info, bold = true })
set("MatchParen", { fg = p.info, bg = p.selection, bold = true })
set("Search", { fg = p.fg, bg = "#334258", underline = true })
group("IncSearch CurSearch", { fg = p.bg, bg = p.info })
set("BlinkCmpLabel", { fg = p.fg })
set("BlinkCmpLabelDeprecated", { fg = p.comment, strikethrough = true })
set("BlinkCmpSource", { fg = p.muted })
set("BlinkCmpDocSeparator", { fg = p.border })
set("BlinkCmpDocCursorLine", { bg = p.raised })
set("BlinkCmpSignatureHelp", { fg = p.fg, bg = p.panel })
set("BlinkCmpSignatureHelpBorder", { fg = p.border, bg = p.panel })
link("BlinkCmpSignatureHelpActiveParameter", "LspSignatureActiveParameter")
for kind, color in pairs({ Function=p.info, Method=p.info, Constructor=p.type,
  Class=p.type, Struct=p.type, Interface=p.type, Enum=p.type, TypeParameter=p.type,
  Variable=p.fg, Field=p.func, Property=p.func, Constant=p.macro, EnumMember=p.func,
  Keyword=p.declaration, Snippet=p.constant, Text=p.muted, File=p.muted, Module=p.type }) do
  set("BlinkCmpKind" .. kind, { fg = color })
end
group("SnacksPickerTitle TelescopeTitle", { fg = p.info, bg = p.panel, bold = true })
group("SnacksPickerPrompt TelescopePromptPrefix", { fg = p.info })
group("SnacksPickerDirectory SnacksPickerDir TelescopeResultsComment", { fg = p.muted })
set("SnacksPickerFile", { fg = p.fg })
set("SnacksPickerSelected", { fg = p.type })
group("NeoTreeNormal NeoTreeNormalNC", { fg = p.fg, bg = p.panel })
set("NeoTreeDirectoryName", { fg = p.info })
set("NeoTreeDirectoryIcon", { fg = p.info })
set("NeoTreeRootName", { fg = p.type, bold = true })
set("NeoTreeFloatBorder", { fg = p.border, bg = p.panel })
set("NeoTreeCursorLine", { bg = p.selection })
set("WhichKeyNormal", { fg = p.fg, bg = p.panel })
set("WhichKeyBorder", { fg = p.border, bg = p.panel })
set("WhichKeyDesc", { fg = p.fg })
set("WhichKeySeparator", { fg = p.comment })
for severity, color in pairs({ Error=p.danger, Warn=p.warning, Info=p.info, Debug=p.hint, Trace=p.comment }) do
  group("Notify"..severity.."Title Notify"..severity.."Icon", { fg = color })
  set("Notify"..severity.."Border", { fg = color, bg = p.panel })
  set("Notify"..severity.."Body", { fg = p.fg, bg = p.panel })
end
set("TroubleNormal", { fg = p.fg, bg = p.panel })
set("TroubleNormalNC", { fg = p.fg, bg = p.panel })
set("TroubleCount", { fg = p.info, bg = p.raised })
set("TroubleIndent", { fg = p.guide })

-- BEGIN PROJECT VSCODE RUST MIGRATION
-- Source: disillusion/.vscode/settings.json
-- SHA-256: a005616614f4cdba0fe8e6e8fe39bb3035e6561c278c3b02f3572d2768f36972
set("@lsp.type.keyword.rust", { fg = "#7893BE" })
set("@lsp.typemod.keyword.controlFlow.rust", { fg = "#B683A2" })
set("@lsp.type.modifier.rust", { fg = "#9DB1D0" })
set("@lsp.type.namespace.rust", { fg = "#9299A4" })
set("@lsp.type.type.rust", { fg = "#50D0CB" })
set("@lsp.type.builtinType.rust", { fg = "#00AA8E", italic = false, bold = true, underline = false, strikethrough = false })
set("@lsp.type.struct.rust", { fg = "#59C8C8" })
set("@lsp.type.enum.rust", { fg = "#00D4D9", italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.type.interface.rust", { fg = "#39A1A1" })
set("@lsp.type.union.rust", { fg = "#1AD6B8" })
set("@lsp.type.typeAlias.rust", { fg = "#1AD6B8" })
set("@lsp.type.typeParameter.rust", { fg = "#ABD186" })
set("@lsp.type.constParameter.rust", { fg = "#DD9051" })
set("@lsp.type.function.rust", { fg = "#79D0F4" })
set("@lsp.type.method.rust", { fg = "#3CCCFD" })
set("@lsp.type.variable.rust", { fg = "#C6C5BB" })
set("@lsp.type.parameter.rust", { fg = "#C9C59F" })
set("@lsp.type.property.rust", { fg = "#D4C494" })
set("@lsp.type.enumMember.rust", { fg = "#D7D37B" })
set("@lsp.typemod.variable.constant.rust", { fg = "#FF9300", italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.type.number.rust", { fg = "#91C970" })
set("@lsp.type.boolean.rust", { fg = "#7EB3E1" })
set("@lsp.type.string.rust", { fg = "#D0957D" })
set("@lsp.type.formatSpecifier.rust", { fg = "#FFC3D8" })
set("@lsp.type.lifetime.rust", { fg = "#E9A2B7" })
set("@lsp.type.label.rust", { fg = "#5580A4" })
set("@lsp.type.attribute.rust", { fg = "#A1C17D" })
set("@lsp.type.decorator.rust", { fg = "#A2A391" })
set("@lsp.type.macro.rust", { fg = "#EE9D30" })
set("@lsp.type.macroBang.rust", { fg = "#EE9D30" })
set("@lsp.type.operator.rust", { fg = "#D9D4C6" })
set("@lsp.type.comment.rust", { fg = "#6D7D66" })
set("@lsp.type.class.rust", { fg = "#75D6C0" })
set("@lsp.type.event.rust", { fg = "#7CCCF5" })
set("@lsp.type.regexp.rust", { fg = "#8586A2" })
set("@lsp.typemod.variable.readonly.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.parameter.readonly.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.property.readonly.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.static.readonly.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.const.readonly.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.variable.static.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.parameter.static.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.property.static.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.static.static.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.const.static.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.variable.modification.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.parameter.modification.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.property.modification.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.static.modification.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.const.modification.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.variable.mutable.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.parameter.mutable.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.property.mutable.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.static.mutable.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.const.mutable.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.parameter.constant.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.property.constant.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.static.constant.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.typemod.const.constant.rust", { italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.mod.deprecated.rust", { italic = false, bold = false, underline = false, strikethrough = true })
set("@lsp.mod.abstract.rust", { italic = false, bold = false, underline = false, strikethrough = true })
set("@lsp.typemod.function.mutable.rust", {})
set("@lsp.typemod.method.mutable.rust", {})
set("@lsp.typemod.selfKeyword.mutable.rust", {})
set("@lsp.mod.mutable.rust", {})
set("@lsp.mod.unsafe.rust", {})
set("@lsp.typemod.keyword.unsafe.rust", {})
set("@lsp.type.const.rust", { fg = "#FF9300", italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.type.static.rust", { fg = "#FF9300", italic = true, bold = false, underline = false, strikethrough = false })
set("@lsp.type.trait.rust", { fg = "#39A1A1" })
set("@lsp.type.procMacro.rust", { fg = "#EE9D30" })
set("@lsp.type.character.rust", { fg = "#D0957D" })
set("@lsp.type.selfKeyword.rust", { fg = "#7893BE" })
set("@lsp.type.selfTypeKeyword.rust", { fg = "#50D0CB" })
set("@lsp.type.escapeSequence.rust", { fg = "#D0957D" })
set("@lsp.type.derive.rust", {})
set("@lsp.type.deriveHelper.rust", {})
set("@lsp.type.builtinAttribute.rust", {})
set("@lsp.type.toolModule.rust", {})
set("@lsp.type.generic.rust", {})
set("@lsp.type.unresolvedReference.rust", {})
set("@lsp.type.invalidEscapeSequence.rust", {})
set("@lsp.type.keyword.rust", {})
set("@lsp.type.comment.rust", {})
set("@lsp.type.string.rust", {})
set("@lsp.type.arithmetic.rust", { fg = "#D9D4C6" })
set("@lsp.type.bitwise.rust", { fg = "#D9D4C6" })
set("@lsp.type.comparison.rust", { fg = "#D9D4C6" })
set("@lsp.type.logical.rust", { fg = "#D9D4C6" })
set("@lsp.type.negation.rust", { fg = "#D9D4C6" })
set("@lsp.type.dot.rust", { fg = "#D9D4C6" })
set("@lsp.type.colon.rust", { fg = "#D9D4C6" })
set("@lsp.type.punctuation.rust", { fg = "#B1995B" })
set("@lsp.type.angle.rust", { fg = "#B1995B" })
set("@lsp.type.brace.rust", { fg = "#B1995B" })
set("@lsp.type.bracket.rust", { fg = "#B1995B" })
set("@lsp.type.parenthesis.rust", { fg = "#B1995B" })
set("@lsp.type.comma.rust", { fg = "#B1995B" })
set("@lsp.type.semi.rust", { fg = "#B1995B" })
set("@lsp.type.semicolon.rust", { fg = "#B1995B" })
set("@lsp.type.attributeBracket.rust", { fg = "#A1C17D" })
set("@comment.rust", { fg = "#6D7D66" })
set("@comment.documentation.rust", { fg = "#6D7D66" })
set("@variable.rust", { fg = "#C6C5BB" })
set("@variable.builtin.rust", { fg = "#7893BE" })
set("@function.rust", { fg = "#79D0F4" })
set("@function.call.rust", { fg = "#79D0F4" })
set("@function.method.rust", { fg = "#79D0F4" })
set("@function.method.call.rust", { fg = "#79D0F4" })
set("@function.builtin.rust", { fg = "#79D0F4" })
set("@function.macro.rust", { fg = "#EE9D30" })
set("@type.rust", { fg = "#50D0CB" })
set("@type.builtin.rust", { fg = "#50D0CB" })
set("@type.definition.rust", { fg = "#1AD6B8" })
set("@constructor.rust", { fg = "#50D0CB" })
set("@module.rust", { fg = "#9299A4" })
set("@module.builtin.rust", { fg = "#9299A4" })
set("@constant.rust", { fg = "#DD9051" })
set("@constant.builtin.rust", { fg = "#DD9051" })
set("@number.rust", { fg = "#91C970" })
set("@number.float.rust", { fg = "#91C970" })
set("@boolean.rust", { fg = "#FF9300" })
set("@string.rust", { fg = "#D0957D" })
set("@character.rust", { fg = "#D0957D" })
set("@string.escape.rust", { fg = "#D0957D" })
set("@string.special.rust", { fg = "#D0957D" })
set("@string.special.symbol.rust", { fg = "#D0957D" })
set("@keyword.rust", { fg = "#7893BE" })
set("@keyword.function.rust", { fg = "#7893BE" })
set("@keyword.type.rust", { fg = "#7893BE" })
set("@keyword.modifier.rust", { fg = "#7893BE" })
set("@keyword.import.rust", { fg = "#7893BE" })
set("@keyword.conditional.rust", { fg = "#B683A2" })
set("@keyword.repeat.rust", { fg = "#B683A2" })
set("@keyword.return.rust", { fg = "#B683A2" })
set("@keyword.exception.rust", { fg = "#B683A2" })
set("@keyword.coroutine.rust", { fg = "#B683A2" })
set("@operator.rust", { fg = "#D9D4C6" })
set("@keyword.operator.rust", { fg = "#D9D4C6" })
set("@attribute.rust", { fg = "#A1C17D" })
set("@punctuation.rust", { fg = "#B1995B" })
set("@punctuation.bracket.rust", { fg = "#B1995B" })
set("@punctuation.delimiter.rust", { fg = "#B1995B" })
set("@punctuation.special.rust", { fg = "#A1C17D" })
set("@variable.parameter.rust", { fg = "#C9C59F" })
set("@variable.member.rust", { fg = "#D4C494" })
set("@property.rust", { fg = "#D4C494" })
set("@label.rust", { fg = "#5580A4" })
-- END PROJECT VSCODE RUST MIGRATION
