return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			-- replace unmaintained (as of 2023-10-21) scss with fork
			parser_config.scss.install_info.url = "https://github.com/savetheclocktower/tree-sitter-scss"
			parser_config.scss.install_info.revision = "3432af0393308cd1e34d048f64dc5bf5c8a9b8b0"

			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"c",
				"cpp",
				"php",
				"lua",
				"python",
				"html",
				"css",
				"scss",
				"latex",
				"bash",
				"gitattributes",
				"gitignore",
				"javascript",
				"json",
				"json5",
				"regex",
				"yaml",
				"typoscript",
			})
		end,
	},
}
