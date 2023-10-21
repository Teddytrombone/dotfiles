return {
	{
		"Mofiqul/dracula.nvim",
		opts = function(_, opts)
			local colors = require("dracula").colors()
			opts.overrides = {
				["@variable"] = { fg = colors.bright_blue },
			}
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "dracula",
		},
	},
}
