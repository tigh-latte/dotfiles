local palette = require "tigh-latte.theme.palette"
return {
	fzfLuaPointer = { link = "@keyword" },
	fzfLuaPrompt = { fg = palette.green },

	FzfLuaFzfPrompt = { fg = palette.red },
	FzfLuaSearch = { fg = palette.red },
	FzfLuaFzfMarker = { fg = palette.blue },
	FzfLuaPathColNr = { fg = palette.blue },
	FzfLuaPathLineNr = { fg = palette.green },
	FzfLuaHeaderText = { fg = palette.red },
	FzfLuaHeaderBind = { fg = palette.yellow },
	FzfLuaLivePrompt = { fg = palette.fg },
}
