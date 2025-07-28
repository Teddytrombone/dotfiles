local util = require("lspconfig.util")
local root_dir = util.root_pattern(".git", "composer.json", ".ddev")(vim.fn.getcwd()) or vim.fn.getcwd()
local exe_path = root_dir .. "/vendor/bin/typo3"
local alternative_exe_path = root_dir .. "/.devel/typo3"

if vim.fn.executable(alternative_exe_path) == 1 then
	exe_path = alternative_exe_path
end

return {
	cmd = { exe_path, "idecompanion:lsp" },
	root_dir = root_dir,
	filetypes = { "html" },
}
