---@type vim.lsp.Config
return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_dir = function(bufnr, on_dir)
		local root_markers = { ".devel", "typo3_src", ".git", "composer.json" }
		-- We fallback to the current working directory if no project root is found
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

		on_dir(project_root)
	end,
}
