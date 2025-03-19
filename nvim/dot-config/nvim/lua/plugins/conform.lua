return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			phpcbf = {
				prepend_args = { "--standard=PSR12", "-n", "-s" },
			},
			php_cs_fixer = {
				prepend_args = { "--config=/var/www/.devel/coding-standards/.php-cs-fixer.php" },
			},
		},
	},
}
