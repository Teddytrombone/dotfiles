return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	enabled = true,
	keys = {
		{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
		{ "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
	},
	config = function()
		require("harpoon").setup()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		-- Harpoon marked files 1 through 4.
		vim.keymap.set("n", "<a-1>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<a-2>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<a-3>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<a-4>", function()
			ui.nav_file(4)
		end)

		-- Harpoon next and previous.
		vim.keymap.set("n", "<A-CR>", function()
			ui.nav_next()
		end)
		vim.keymap.set("n", "<A-BS>", function()
			ui.nav_prev()
		end)

		-- Harpoon user interface.
		vim.keymap.set("n", "<a-7>", ui.toggle_quick_menu)
		vim.keymap.set("n", "<a-8>", mark.add_file)
	end,
}
