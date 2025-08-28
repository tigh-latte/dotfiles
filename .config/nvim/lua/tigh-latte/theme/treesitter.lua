local palette = require "tigh-latte.theme.palette"
local M = {
	["@text"] = { fg = palette.fg },
	["@operator"] = { fg = palette.fg },

	["@annotation"] = { fg = palette.fg },
	["@keyword"] = { fg = palette.yellow },
	["@keyword.return"] = { fg = palette.yellow },
	["@keyword.import"] = { fg = palette.yellow },
	["@keyword.operator"] = { fg = palette.yellow },
	["@keyword.exception"] = { fg = palette.yellow },
	["@keyword.directive"] = { fg = palette.yellow },
	["@keyword.conditional"] = { fg = palette.yellow },
	["@keyword.function"] = { fg = palette.yellow },
	["@conditional"] = { fg = palette.yellow },
	["@include"] = { fg = palette.yellow },
	["@keyword.repeat"] = { fg = palette.yellow },
	["@lsp.type.builtinType"] = { fg = palette.green },
	["@type"] = { fg = palette.fg },
	["@type.builtin"] = { fg = palette.green },
	["@lsp.type.enumMemeber"] = { fg = palette.green },

	-- declarations
	["@attribute"] = { fg = palette.fg },
	["@variable"] = { fg = palette.fg },
	["@variable.member"] = { fg = palette.fg },
	["@variable.builtin"] = { fg = palette.fg },
	["@variable.parameter"] = { fg = palette.fg },
	["@property"] = { fg = palette.fg },
	["@constant"] = { fg = palette.fg },
	["@constant.builtin"] = { fg = palette.red },
	["@constant.macro"] = { fg = palette.fg },
	["@module"] = { fg = palette.fg },
	["@module.builtin"] = { fg = palette.fg },
	["@namespace"] = { fg = palette.fg },
	["@field"] = { fg = palette.fg },

	-- punctuation
	["@punctuation.bracket"] = { fg = palette.fg },
	["@punctuation.delimiter"] = { fg = palette.fg },

	-- literals
	["@comment"] = { fg = palette.grey },
	["@string"] = { fg = palette.red },
	["@string.regexp"] = { fg = palette.red },
	["@string.special.symbol"] = { fg = palette.red },
	["@string.special.url"] = { fg = palette.red },
	["@text.literal"] = { fg = palette.red },
	["@number"] = { fg = palette.red },
	["@float"] = { fg = palette.red },
	["@number.float"] = { fg = palette.red },
	["@boolean"] = { fg = palette.red },
	["@null"] = { fg = palette.red },

	-- functions
	["@method"] = { fg = palette.fg },
	["@function"] = { fg = palette.fg },
	["@function.call"] = { fg = palette.fg },
	["@function.method"] = { fg = palette.fg },
	["@function.builtin"] = { fg = palette.cyan },
	["@function.macro"] = { fg = palette.fg },
	["@attribute.typescript"] = { fg = palette.fg },
	["@constructor"] = { fg = palette.fg },

	-- lsp
	["@lsp.type.method"] = { fg = palette.fg },
	["@lsp.type.property"] = { fg = palette.fg },
	["@lsp.type.type"] = { fg = palette.green },
	["@lsp.type.parameter"] = { fg = palette.fg },
	["@lsp.typemod.method.defaultLibrary"] = { fg = palette.fg },
	["@lsp.typemod.function.defaultLibrary"] = { fg = palette.cyan },
	["@lsp.typemod.variable.defaultLibrary"] = { fg = palette.fg },
	["@lsp.typemod.string.injected"] = { fg = palette.red },

	["@character"] = { fg = palette.orange },
	["@comment.todo"] = { fg = palette.red },
	["@comment.todo.unchecked"] = { fg = palette.red },
	["@comment.todo.checked"] = { fg = palette.green },
	-- ["@diff.add"] = hl.common.DiffAdded,
	-- ["@diff.delete"] = hl.common.DiffDeleted,
	-- ["@diff.plus"] = hl.common.DiffAdded,
	-- ["@diff.minus"] = hl.common.DiffDeleted,
	-- ["@diff.delta"] = hl.common.DiffChanged,
	["@error"] = { fg = palette.fg },
	["@label"] = { fg = palette.red },
	["@markup.emphasis"] = { fg = palette.fg, italic = true },
	["@markup.environment"] = { fg = palette.fg },
	["@markup.environment.name"] = { fg = palette.fg },
	["@markup.heading"] = { fg = palette.orange, bold = true },
	["@markup.link"] = { fg = palette.blue },
	["@markup.link.url"] = { fg = palette.cyan, underline = true },
	["@markup.list"] = { fg = palette.red },
	["@markup.math"] = { fg = palette.fg },
	["@markup.raw"] = { fg = palette.green },
	["@markup.strike"] = { fg = palette.fg, strikethrough = true },
	["@markup.strong"] = { fg = palette.fg, bold = true },
	["@markup.underline"] = { fg = palette.fg, underline = true },
	["@none"] = { fg = palette.fg },
	["@parameter.reference"] = { fg = palette.fg },
	["@string.escape"] = { fg = palette.red },
	["@tag"] = { fg = palette.purple },
	["@tag.attribute"] = { fg = palette.yellow },
	["@tag.delimiter"] = { fg = palette.purple },
	["@note"] = { fg = palette.fg },
	["@warning"] = { fg = palette.fg },
	["@danger"] = { fg = palette.fg },
	["@markup.heading.1.markdown"] = { fg = palette.red, bold = true },
	["@markup.heading.2.markdown"] = { fg = palette.purple, bold = true },
	["@markup.heading.3.markdown"] = { fg = palette.orange, bold = true },
	["@markup.heading.4.markdown"] = { fg = palette.red, bold = true },
	["@markup.heading.5.markdown"] = { fg = palette.purple, bold = true },
	["@markup.heading.6.markdown"] = { fg = palette.orange, bold = true },
	["@markup.heading.1.marker.markdown"] = { fg = palette.red, bold = true },
	["@markup.heading.2.marker.markdown"] = { fg = palette.purple, bold = true },
	["@markup.heading.3.marker.markdown"] = { fg = palette.orange, bold = true },
	["@markup.heading.4.marker.markdown"] = { fg = palette.red, bold = true },
	["@markup.heading.5.marker.markdown"] = { fg = palette.purple, bold = true },
	["@markup.heading.6.marker.markdown"] = { fg = palette.orange, bold = true },
}

M["@lsp.type.comment"] = M["@comment"]
M["@lsp.type.enum"] = M["@type"]
M["@lsp.type.enumMember"] = M["@constant.builtin"]
M["@lsp.type.interface"] = M["@type"]
M["@lsp.type.typeParameter"] = M["@type"]
M["@lsp.type.keyword"] = M["@keyword"]
M["@lsp.type.namespace"] = M["@module"]
M["@lsp.type.variable"] = M["@variable"]
M["@lsp.type.macro"] = M["@function.macro"]
M["@lsp.type.number"] = M["@number"]
M["@lsp.type.generic"] = M["@text"]
M["@lsp.type.builtinType"] = M["@type.builtin"]
M["@lsp.typemod.operator.injected"] = M["@operator"]
M["@lsp.typemod.variable.injected"] = M["@variable"]
M["@lsp.typemod.variable.static"] = M["@constant"]

return M
