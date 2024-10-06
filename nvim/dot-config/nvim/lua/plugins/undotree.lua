return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = { { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "UndoTree Toggle" } },
	config = function()
		vim.g.undotree_TreeNodeShape = "◦" -- Alternative: '◉'
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
