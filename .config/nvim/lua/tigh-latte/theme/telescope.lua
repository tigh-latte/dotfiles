local palette = require "tigh-latte.theme.palette"
return {
	TelescopeBorder = { fg = palette.red },
	TelescopePromptBorder = { fg = palette.cyan },
	TelescopeResultsBorder = { fg = palette.cyan },
	TelescopePreviewBorder = { fg = palette.cyan },
	TelescopeMatching = { fg = palette.orange, bold = true },
	TelescopePromptPrefix = { fg = palette.green },
	TelescopeSelection = { bg = palette.bg2 },
	TelescopeSelectionCaret = { fg = palette.yellow },
}
