-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("indent_2", { clear = true }),
	pattern = { "yml", "yaml" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("typoscript", { clear = true }),
	pattern = { "typoscript", "tsconfig", "ext_typoscript_setup.txt" },
	callback = function()
		vim.treesitter.start()
	end,
})
