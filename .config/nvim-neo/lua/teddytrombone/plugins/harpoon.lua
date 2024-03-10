return {
	-- Jump quickly between often used files.
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = true,
	event = "BufEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():append()
		end, { desc = "Append Buffer to Harppon" })

		vim.keymap.set("n", "<A-1>", function()
			harpoon:list():select(1)
		end, { desc = "Jump to first buffer" })
		vim.keymap.set("n", "<A-2>", function()
			harpoon:list():select(2)
		end, { desc = "Jump to second buffer" })
		vim.keymap.set("n", "<A-3>", function()
			harpoon:list():select(3)
		end, { desc = "Jump to third buffer" })
		vim.keymap.set("n", "<A-4>", function()
			harpoon:list():select(4)
		end, { desc = "Jump to forth buffer" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-1>", function()
			harpoon:list():prev()
		end, { desc = "Toggle prev Buffer" })
		vim.keymap.set("n", "<C-2>", function()
			harpoon:list():next()
		end, { desc = "Toggle next Buffer" })

		-- Integrate Harpoon with Telescope
		-- local testTelescope, conf = pcall(require, "telescope.config")
		-- if testTelescope then
		-- 	local telescopeValues = conf.values
		-- 	local function toggle_telescope(harpoon_files)
		-- 		local file_paths = {}
		-- 		for _, item in ipairs(harpoon_files.items) do
		-- 			table.insert(file_paths, item.value)
		-- 		end
		--
		-- 		require("telescope.pickers")
		-- 			.new({}, {
		-- 				prompt_title = "Harpoon",
		-- 				finder = require("telescope.finders").new_table({
		-- 					results = file_paths,
		-- 				}),
		-- 				previewer = conf.file_previewer({}),
		-- 				sorter = conf.generic_sorter({}),
		-- 			})
		-- 			:find()
		-- 	end
		-- 	vim.keymap.set("n", "<C-e>", function()
		-- 		toggle_telescope(harpoon:list())
		-- 	end, { desc = "Open Harpoon Window" })
		-- else
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon Quick menu" })
		-- end
	end,
}
