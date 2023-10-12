return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		nesting_rules = {
			["js"] = { "js.map", "min.js", "d.ts" },
			["package.json"] = { "package-lock.json", "yarn.lock" },
			["svg"] = { "svgz", "svg.br" },
			["css"] = { "css.map", "min.css" },
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_by_name = {
					"__pycache__",
					".git",
					".vscode",
					".DS_Store",
					".Build",
				},
				never_show = {
					".php-cs-fixer.cache",
				},
				never_show_by_pattern = {
					".null-ls_*",
					"*/.devel/em",
					"*/.devel/sn",
					"*/.devel/cp",
				},
			},
			commands = {
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify
					local extensionPaths = { "typo3conf/ext/", "typo3/sysext/" }

					local vals = {
						["BASENAME"] = modify(filename, ":r"),
						["EXTENSION"] = modify(filename, ":e"),
						["FILENAME"] = filename,
						["PATH (CWD)"] = modify(filepath, ":."),
						["PATH (HOME)"] = modify(filepath, ":~"),
						["PATH"] = filepath,
						["URI"] = vim.uri_from_fname(filepath),
					}

					for _, typo3path in ipairs(extensionPaths) do
						local position = string.find(filepath, typo3path)
						if position then
							vals.TYPO3 = string.sub(filepath, position + string.len(typo3path), -1)
							vals.TYPO3EXT = "EXT:" .. string.sub(filepath, position + string.len(typo3path), -1)
						end
					end

					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						vim.notify("No values to copy", vim.log.levels.WARN)
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							vim.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
			},
			window = {
				mappings = {
					["Y"] = "copy_selector",
				},
			},
		},
	},
}
