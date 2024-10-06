local cssDefault = {
	css = true,
	RRGGBBAA = true,
}

return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			filetypes = {
				css = cssDefault,
				scss = cssDefault,
			},
			user_default_options = { mode = "virtualtext" },
		})
	end,
}
