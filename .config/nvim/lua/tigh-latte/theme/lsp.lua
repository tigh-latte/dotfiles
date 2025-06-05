local palette = require "tigh-latte.theme.palette"

local M = {
	LspCxxHlGroupEnumConstant = { fg = palette.orange },
	LspCxxHlGroupMemberVariable = { fg = palette.orange },
	LspCxxHlGroupNamespace = { fg = palette.blue },
	LspCxxHlSkippedRegion = { fg = palette.grey },
	LspCxxHlSkippedRegionBeginEnd = { fg = palette.red },

	DiagnosticError = { fg = palette.red },
	DiagnosticHint = { fg = palette.purple },
	DiagnosticInfo = { fg = palette.cyan },
	DiagnosticWarn = { fg = palette.yellow },

	DiagnosticVirtualTextError = {
		bg = "none",
		fg = palette.red,
	},
	DiagnosticVirtualTextWarn = {
		bg = "none",
		fg = palette.yellow,
	},
	DiagnosticVirtualTextInfo = {
		bg = "none",
		fg = palette.cyan,
	},
	DiagnosticVirtualTextHint = {
		bg = "none",
		fg = palette.purple,
	},

	DiagnosticUnderlineError = { underline = true, sp = palette.red },
	DiagnosticUnderlineHint = { underline = true, sp = palette.purple },
	DiagnosticUnderlineInfo = { underline = true, sp = palette.blue },
	DiagnosticUnderlineWarn = { underline = true, sp = palette.yellow },
	DiagnosticUnnecessary = { fg = palette.grey },

	LspReferenceText = { bg = palette.bg2 },
	LspReferenceWrite = { bg = palette.bg2 },
	LspReferenceRead = { bg = palette.bg2 },

	LspCodeLens = { fg = palette.grey },
	LspCodeLensSeparator = { fg = palette.grey },
}

M.LspDiagnosticsDefaultError = M.DiagnosticError
M.LspDiagnosticsDefaultHint = M.DiagnosticHint
M.LspDiagnosticsDefaultInformation = M.DiagnosticInfo
M.LspDiagnosticsDefaultWarning = M.DiagnosticWarn
M.LspDiagnosticsUnderlineError = M.DiagnosticUnderlineError
M.LspDiagnosticsUnderlineHint = M.DiagnosticUnderlineHint
M.LspDiagnosticsUnderlineInformation = M.DiagnosticUnderlineInfo
M.LspDiagnosticsUnderlineWarning = M.DiagnosticUnderlineWarn
M.LspDiagnosticsVirtualTextError = M.DiagnosticVirtualTextError
M.LspDiagnosticsVirtualTextWarning = M.DiagnosticVirtualTextWarn
M.LspDiagnosticsVirtualTextInformation = M.DiagnosticVirtualTextInfo
M.LspDiagnosticsVirtualTextHint = M.DiagnosticVirtualTextHint

return M
