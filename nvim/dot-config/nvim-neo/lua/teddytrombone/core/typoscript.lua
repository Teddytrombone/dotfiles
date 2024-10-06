vim.filetype.add({
	pattern = {
		[".*/*.typoscript"] = "typoscript",
		[".*/*.tsconfig"] = "typoscript",
		[".*/ext_typoscript_setup.txt"] = "typoscript",
	},
})
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("typoscript", { clear = true }),
-- 	pattern = { "typoscript", "tsconfig", "ext_typoscript_setup.txt" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })
