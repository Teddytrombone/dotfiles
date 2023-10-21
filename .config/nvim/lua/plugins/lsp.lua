local util = require("lspconfig.util")
return {
	"neovim/nvim-lspconfig",
	opts = {
		-- make sure mason installs the server
		servers = {
			html = {
				root_dir = function(pattern)
					local cwd = vim.loop.cwd()
					local root = util.root_pattern("composer.json", ".git", "package.json")(pattern)

					-- prefer cwd if root is a descendant
					return util.path.is_descendant(cwd, root) and cwd or root
				end,
			},
			lemminx = {
				filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "html" },
				settings = {
					xml = {
						catalogs = { "/home/manfred/Programmieren/catalog.xml" },
					},
				},
			},
		},
	},
}
