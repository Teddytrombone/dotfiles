local typoscript = {
	icon = "",
	color = "#FF8700",
	name = "TypoScript",
}

return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override_by_filename = {
					["ext_typoscript_setup.txt"] = typoscript,
				},
				override_by_extension = {
					["typoscript"] = typoscript,
					["tsconfig"] = typoscript,
				},
			})
		end,
	},
}
