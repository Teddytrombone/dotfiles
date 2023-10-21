return {
	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config["typoscript"] = {
				install_info = {
					url = "https://github.com/Teddytrombone/tree-sitter-typoscript", -- local path or git repo
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					branch = "main", -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
			}

			vim.treesitter.language.register("typoscript", "typoscript")
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
