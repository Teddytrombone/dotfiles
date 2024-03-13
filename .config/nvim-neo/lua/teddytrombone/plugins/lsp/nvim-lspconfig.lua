return {
	{
		"neovim/nvim-lspconfig",
		-- event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function(_, _)
			require("neodev").setup()
			local util = require("lspconfig.util")
			local utils = require("teddytrombone.utils.lsp")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
		end,
	},
}
