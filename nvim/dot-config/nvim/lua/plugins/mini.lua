local typoscript = { glyph = "", hl = "TYPO3" }
return {
	"nvim-mini/mini.icons",
	opts = {
		filetype = {
			typoscript = typoscript,
			ghostty = { glyph = "󱙝", hl = "GHOSTTY" },
		},
	},
}
