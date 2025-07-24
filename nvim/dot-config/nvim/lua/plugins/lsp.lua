local util = require("lspconfig.util")

return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local lsp = require("lspconfig")

		-- make sure mason installs the server
		opts.servers = vim.list_extend(opts.servers, {
			typo3 = {},
			intelephense = {
				settings = {
					files = {
						exclude = {
							"**/.devel/",
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
			yamlls = {
				settings = {
					yaml = {
						format = {
							enable = false,
							-- disable = true
						},
					},
				},
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
