---@type vim.lsp.Config
return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { ".ddev", ".devel", "typo3_src", { ".git", "composer.json" } },
}
