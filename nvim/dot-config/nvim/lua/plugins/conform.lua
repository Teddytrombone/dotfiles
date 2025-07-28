local function getConfigFile()
	local root_dir = vim.fn.getcwd()

	local candidates = {
		root_dir .. "/.php-cs-fixer.php",
		root_dir .. "/.devel/.php-cs-fixer.php",
		root_dir .. "/.devel/coding-standards/.php-cs-fixer.php",
		vim.fn.expand("$HOME/Programmieren/coding-standards/.php-cs-fixer.php"),
		"/var/www/.devel/coding-standards/.php-cs-fixer.php",
	}
	for _, candidate in ipairs(candidates) do
		if vim.fn.filereadable(candidate) == 1 then
			return candidate
		end
	end

	return ""
end

return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			phpcbf = {
				prepend_args = { "--standard=PSR12", "-n", "-s" },
			},
			php_cs_fixer = {
				prepend_args = { "--config=" .. getConfigFile() },
			},
		},
	},
}
