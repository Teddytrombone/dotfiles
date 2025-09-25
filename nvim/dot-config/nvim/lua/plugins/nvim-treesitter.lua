return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			-- replace unmaintained (as of 2023-10-21) scss with fork
			-- parser_config.scss.install_info.url = "https://github.com/savetheclocktower/tree-sitter-scss"
			-- parser_config.scss.install_info.revision = "090d25a5fc829ce6956201cf55ab6b6eacad999c"

			-- parser_config.typoscript.install_info.revision = "5d8fde870b0ded1f429ba5bb249a9d9f8589ff5f"

			-- parser_config.html.install_info.url = "https://github.com/Teddytrombone/tree-sitter-html-fluid"
			-- parser_config.html.install_info.revision = "2b0142b5b723a0e956a50539514123299f9b9550"

			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"c",
				"cpp",
				"php",
				"lua",
				"python",
				"html",
				"css",
				-- "scss",
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
