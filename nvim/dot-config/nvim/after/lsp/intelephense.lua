---@type vim.lsp.Config
return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_dir = function(bufnr, on_dir)
		local project_root = vim.fs.root(bufnr, { ".devel" })

		local root_markers = { "typo3_src", ".git", "composer.json" }
		if not project_root or project_root == "/var/www" then
			-- We fallback to the current working directory if no project root is found
			project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
		end

		on_dir(project_root)
	end,
}
