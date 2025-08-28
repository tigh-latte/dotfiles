local palette = require "tigh-latte.theme.palette"
return {
	fzfLuaPointer = { fg = palette.red },
	fzfLuaPrompt = { fg = palette.green },

	FzfLuaHL = { fg = palette.yellow, bold = false },
	FzfLuaFGPlus = { fg = palette.fg, bold = false },
	FzfLuaHLPlus = { fg = palette.yellow, bold = false },
	FzfLuaInfo = { fg = palette.grey },
	FzfLuaFzfPrompt = { fg = palette.red },
	FzfLuaSearch = { fg = palette.red },
	FzfLuaFzfMarker = { fg = palette.blue },
	FzfLuaPathColNr = { fg = palette.blue },
	FzfLuaPathLineNr = { fg = palette.green },
	FzfLuaHeaderText = { fg = palette.red },
	FzfLuaHeaderBind = { fg = palette.yellow },
	FzfLuaLivePrompt = { fg = palette.fg },
}
