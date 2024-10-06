-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<A-Up>", "<C-A>", { desc = "Increase number", remap = true })
vim.keymap.set("n", "<A-Down>", "<C-X>", { desc = "Decrease number", remap = true })
