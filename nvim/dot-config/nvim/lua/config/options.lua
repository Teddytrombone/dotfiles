-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.api.nvim_set_hl(0, "TYPO3", { fg = "#FF8700", bg = nil })
vim.api.nvim_set_hl(0, "GHOSTTY", { fg = "#3551f3", bg = nil })

vim.g.snacks_animate = false
-- vim.g.lazyvim_php_lsp = "intelephense"
