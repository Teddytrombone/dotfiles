local util = require("lspconfig.util")

return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local lsp = require("lspconfig")

		vim.tbl_deep_extend("keep", lsp, {
			typo3 = {
				cmd = { "/usr/bin/php74", "typo3/sysext/core/bin/typo3", "idecompanion:lsp" },
				root_dir = util.root_pattern("typo3"),
				filetypes = { "html" },
			},
		})
		-- make sure mason installs the server
		opts.servers = vim.list_extend(opts.servers, {
			typo3 = {},
			intelephense = {
				settings = {
					files = {
						exclude = {
							"**/.devel/",
							"**/typo3_src-**/",
							"typo3/",
						},
					},
				},
			},
			html = {
				root_dir = function(pattern)
					local cwd = vim.loop.cwd()
					local root = util.root_pattern("composer.json", ".git", "package.json")(pattern)

					-- prefer cwd if root is a descendant
					return util.path.is_descendant(cwd, root) and cwd or root
				end,
			},
			-- lemminx = {
			-- 	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
			-- 	--filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "html" },
			-- 	settings = {
			-- 		xml = {
			-- 			--catalogs = { "/home/manfred/Programmieren/catalog.xml" },
			-- 		},
			-- 	},
			-- },
		})
	end,
}
