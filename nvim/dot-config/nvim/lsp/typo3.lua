local util = require("lspconfig.util")
local root_dir = util.root_pattern(".git", "composer.json")(vim.fn.getcwd()) or vim.fn.getcwd()
local exe_path = root_dir .. "/vendor/bin/typo3"
return {
	cmd = { exe_path, "idecompanion:lsp" },
	root_dir = root_dir,
	filetypes = { "html" },
}
