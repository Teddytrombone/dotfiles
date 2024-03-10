return {
	"rcarriga/nvim-notify",
	opts = {
		background_colour = "#000000",
	},
	config = function()
		require("notify").setup()
	end,
}
