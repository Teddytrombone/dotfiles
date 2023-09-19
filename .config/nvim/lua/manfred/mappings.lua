local wk = require("which-key")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

wk.register({
  ["<leader>f"] = { name = "+file" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Find File (grep)" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>tf", ":NvimTreeFocus<CR>", {silent = true})

