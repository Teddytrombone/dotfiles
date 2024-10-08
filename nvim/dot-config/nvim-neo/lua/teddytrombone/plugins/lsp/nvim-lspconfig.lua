return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(_, _)
			local utils = require("teddytrombone.utils.lsp")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities(capabilities))
			utils.typo3_lsp(lspconfig)
			utils.setup()

			mason_lspconfig.setup({
				ensure_installed = utils.lsp_servers,
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["intelephense"] = function()
					lspconfig.intelephense.setup({
						capabilities = capabilities,
						root_dir = utils.php_root_dir,
					})
				end,
				["phpactor"] = function()
					lspconfig.phpactor.setup({
						capabilities = capabilities,
						root_dir = utils.php_root_dir,
					})
				end,
			})

			lspconfig.typo3.setup({})
		end,
	},
}
