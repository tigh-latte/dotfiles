local palette = require "tigh-latte.theme.palette"
return {
	openscadinclude = { fg = palette.yellow },
	openscadBinaryoperator = { fg = palette.fg },
	openscadNumber = { fg = palette.red, bold = false },
	openscadBoolean = { fg = palette.red, bold = false },
	openscadCsgKeyword = { fg = palette.cyan },
	openscadBuiltin = { fg = palette.blue },
	openscadPrimitive2D = { fg = palette.green },
	openscadPrimitiveSolid = { fg = palette.green },
	openscadPrimitiveImport = { fg = palette.cyan },
	openscadRepeat = { fg = palette.yellow },
	openscadModuleDef = { fg = palette.yellow },
}
