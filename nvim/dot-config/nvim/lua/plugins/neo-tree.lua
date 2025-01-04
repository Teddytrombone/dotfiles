local Util = require("lazyvim.util")

return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		nesting_rules_ = {
			["js"] = {
				pattern = "^(.+)%.js$",
				files = { "%1.js.map", "%1.*.js", "%1.d.ts" },
			},
			[".gitignore"] = {
				pattern = "^%.gitignore$",
				files = { ".gitattributes", ".gitmodules", ".gitmessage", ".mailmap", ".git-blame*" },
			},
			["package.json"] = {
				pattern = "^package%.json$",
				files = {
					"package-lock.json",
					"yarn*",
					".browserslist*",
					".circleci*",
					".commitlint*",
					".cz-config.js",
					".czrc",
					".dlint.json",
					".dprint.json*",
					".editorconfig",
					".eslint*",
					".firebase*",
					".flowconfig",
					".github*",
					".gitlab*",
					".gitpod*",
					".huskyrc*",
					".jslint*",
					".lintstagedrc*",
					".markdownlint*",
					".node-version",
					".nodemon*",
					".npm*",
					".nvmrc",
					".pm2*",
					".pnp.*",
					".pnpm*",
					".prettier*",
					".release-please*.json",
					".releaserc*",
					".sentry*",
					".simple-git-hooks*",
					".stackblitz*",
					".styleci*",
					".stylelint*",
					".tazerc*",
					".textlint*",
					".tool-versions",
					".travis*",
					".versionrc*",
					".vscode*",
					".watchman*",
					".xo-config*",
					".yamllint*",
					".yarnrc*",
					"Procfile",
					"apollo.config.*",
					"appveyor*",
					"azure-pipelines*",
					"bower.json",
					"build.config.*",
					"bun.lockb",
					"commitlint*",
					"crowdin*",
					"dangerfile*",
					"dlint.json",
					"dprint.json*",
					"electron-builder.*",
					"eslint*",
					"firebase.json",
					"grunt*",
					"gulp*",
					"jenkins*",
					"lerna*",
					"lint-staged*",
					"nest-cli.*",
					"netlify*",
					"nodemon*",
					"npm-shrinkwrap.json",
					"nx.*",
					"package.nls*.json",
					"phpcs.xml",
					"pm2.*",
					"pnpm*",
					"prettier*",
					"pullapprove*",
					"pyrightconfig.json",
					"release-please*.json",
					"release-tasks.sh",
					"release.config.*",
					"renovate*",
					"rollup.config.*",
					"rspack*",
					"simple-git-hooks*",
					"stylelint*",
					"tslint*",
					"tsup.config.*",
					"turbo*",
					"typedoc*",
					"unlighthouse*",
					"vercel*",
					"vetur.config.*",
					"webpack*",
					"workspace.json",
					"xo.config.*",
				},
			},
			["readme"] = {
				pattern = "^readme.*",
				ignore_case = true,
				files = {
					"authors",
					"backers*",
					"changelog*",
					"citation*",
					"code_of_conduct*",
					"codeowners",
					"contributing*",
					"contributors",
					"copying*",
					"credits",
					"governance.md",
					"history.md",
					"license*",
					"maintainers",
					"readme*",
					"security.md",
					"sponsors*",
				},
			},
			["docker"] = {
				pattern = "^dockerfile$",
				ignore_case = true,
				files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
			},
			["composer.json"] = {
				pattern = "^composer%.json$",
				files = { ".php*.cache", "composer.lock", "phpunit.xml*", "psalm*.xml" },
			},
			[".env"] = {
				pattern = "^%.env$",
				files = { "*.env", ".env.*", ".envrc", "env.d.ts" },
			},
			["tex"] = {
				pattern = "^(.*)%.tex$",
				files = {
					"%1.acn",
					"%1.acr",
					"%1.alg",
					"%1.aux",
					"%1.bbl",
					"%1.blg",
					"%1.fdb_latexmk",
					"%1.fls",
					"%1.glg",
					"%1.glo",
					"%1.gls",
					"%1.idx",
					"%1.ind",
					"%1.ist",
					"%1.lof",
					"%1.log",
					"%1.lot",
					"%1.out",
					"%1.pdf",
					"%1.synctex.gz",
					"%1.toc",
					"%1.xdv",
				},
			},
			["jsx"] = {
				pattern = "^(.*)%.jsx$",
				files = { "%1.js", "%1.*.jsx", "%1_*.js", "%1_*.jsx", "%1.less", "%1.module.less" },
			},
			["ts"] = {
				pattern = "^(.*)%.ts$",
				files = { "%1.js", "%1.d.ts.map", "%1.*.ts", "%1_*.js", "%1_*.ts" },
			},
			["svg"] = {
				pattern = "^(.*)%.svg$",
				files = { "%1.svgz", "%1.svg.*" },
			},
			["css"] = {
				pattern = "^(.*)%.css$",
				files = { "%1.css.map", "%1.*.css" },
			},
			-- for testing
			["go"] = {
				pattern = "(.*)%.go$",
				files = { "%1_test.go" },
			},
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
					"_processed_",
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
					Util.telescope("live_grep", { cwd = dir })()
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
					["Y"] = "copy_selector",
					["F"] = "find_in_dir",
				},
			},
		},
	},
}
