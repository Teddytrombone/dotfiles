---@type vim.lsp.Config
return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { ".devel", "typo3_src", ".git", "composer.json" },
}
