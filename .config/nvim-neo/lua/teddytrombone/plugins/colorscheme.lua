return {
	-- {
	-- 	"Mofiqul/dracula.nvim",
	-- 	opts = function(_, opts)
	-- 		local colors = require("dracula").colors()
	-- 		opts.transparent_bg = true
	-- 		opts.overrides = {
	-- 			["@variable"] = { fg = colors.bright_blue },
	-- 		}
	-- 	end,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("dracula")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			local catppuccin = require("catppuccin")

			catppuccin.setup({
				flavour = "mocha",
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
