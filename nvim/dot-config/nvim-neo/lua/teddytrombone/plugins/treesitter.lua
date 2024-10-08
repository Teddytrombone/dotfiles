return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		opts = function(_, opts)
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			-- replace unmaintained (as of 2023-10-21) scss with fork
			parser_config.scss.install_info.url = "https://github.com/savetheclocktower/tree-sitter-scss"
			parser_config.scss.install_info.revision = "090d25a5fc829ce6956201cf55ab6b6eacad999c"

			parser_config.html.install_info.url = "https://github.com/Teddytrombone/tree-sitter-html-fluid"
			parser_config.html.install_info.revision = "2b0142b5b723a0e956a50539514123299f9b9550"

			-- add tsx and treesitter
			opts.ensure_installed = {
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
				"vim",
				"markdown",
				"markdown_inline",
			}
			opts.highlight = { enable = true }
			opts.indent = { enable = false }

			opts.incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			}
			opts.textobjects = {
				move = {
					enable = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
				},
			}
		end,
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
