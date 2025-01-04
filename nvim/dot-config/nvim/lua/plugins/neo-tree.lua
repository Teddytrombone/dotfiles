local web_devicons = nil
local icon_provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
	if node.type == "file" or node.type == "terminal" then
		if web_devicons == nil then
			web_devicons = require("nvim-web-devicons")
		end
		local devicon = nil
		local hl = nil
		if node.type == "terminal" then
			devicon, hl = web_devicons.get_icon("terminal")
		else
			-- prefer filetype for typoscript files
			local filetype = vim.filetype.match({ filename = node.path })
			if filetype == "typoscript" then
				devicon, hl = web_devicons.get_icon_by_filetype(filetype)
			else
				devicon, hl = web_devicons.get_icon(node.path)
			end
		end
		icon.text = devicon or icon.text
		icon.highlight = hl or icon.highlight
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = vim.tbl_deep_extend("keep", require("plugins.neo-tree.nesting-rules"), {
		default_component_configs = {
			icon = {
				provider = icon_provider,
			},
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_by_name = {
					"__pycache__",
				},
				never_show = {
					".php-cs-fixer.cache",
					"_processed_",
					".git",
					".DS_Store",
					".Build",
				},
				never_show_by_pattern = {
					".null-ls_*",
					"*/.devel/em",
					"*/.devel/sn",
					"*/.devel/cp",
					"*/fileadmin/user_upload",
				},
			},
			commands = {
				find_in_dir = function(state)
					local node = state.tree:get_node()
					local dir
					if node.type == "directory" then
						dir = node.path
					else
						dir = state.tree.nodes.by_id[node._parent_id].path
					end
					LazyVim.pick("live_grep", { cwd = dir })()
				end,
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
					["<space>"] = "none",
					["<A-CR>"] = "toggle_node",
					["Y"] = "copy_selector",
					["F"] = "find_in_dir",
				},
			},
		},
	}),
}
