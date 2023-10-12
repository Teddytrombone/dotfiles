-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.filetype.add({
	extension = {
		typoscript = "typoscript",
		tsconfig = "typoscript",
	},
})

vim.filetype.add({
	filename = {
		["ext_typoscript_setup.txt"] = "typoscript",
	},
})
