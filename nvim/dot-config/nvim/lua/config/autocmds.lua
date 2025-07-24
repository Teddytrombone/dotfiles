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

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("typoscript", { clear = true }),
-- 	pattern = { "typoscript", "tsconfig", "ext_typoscript_setup.txt" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "html" },
-- 	callback = function()
-- 		vim.lsp.start({
-- 			name = "typo3",
-- 			cmd = { "/usr/bin/php74", "/var/www/bluechip/typo3/sysext/core/bin/typo3", "idecompanion:lsp" },
-- 			root_dir = "/var/www/bluechip/",
-- 		})
-- 	end,
-- 	group = vim.api.nvim_create_augroup("typo3", { clear = true }),
-- })
