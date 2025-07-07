local palette = require "tigh-latte.theme.palette"
return {
	FugitiveblameTime = { fg = palette.muted_pink },
	FugitiveblameUncommitted = { link = "Comment" },
	FugitiveblameDelimiter = { fg = palette.fg },

	fugitiveCount = { fg = palette.fg },

	fugitiveStagedSection = { fg = palette.green },
	fugitiveStagedHeading = { fg = palette.fg },

	fugitiveUnstagedSection = { fg = palette.red },
	fugitiveUnstagedHeading = { fg = palette.fg },

	fugitiveUntrackedSection = { fg = palette.red },
	fugitiveUntrackedHeading = { fg = palette.fg },
	fugitiveUntrackedModifier = { fg = palette.fg },

}
