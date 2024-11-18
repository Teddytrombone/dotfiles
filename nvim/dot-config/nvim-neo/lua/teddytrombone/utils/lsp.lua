local M = {}

M.lsp_kinds = {
	Array = " ",
	Boolean = "󰨙 ",
	Class = " ",
	Codeium = "󰘦 ",
	Color = " ",
	Control = " ",
	Collapsed = " ",
	Constant = "󰏿 ",
	Constructor = " ",
	Copilot = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Key = " ",
	Keyword = " ",
	Method = "󰊕 ",
	Module = " ",
	Namespace = "󰦮 ",
	Null = " ",
	Number = "󰎠 ",
	Object = " ",
	Operator = " ",
	Package = " ",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	String = " ",
	Struct = "󰆼 ",
	TabNine = "󰏚 ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = "󰀫 ",
}

M.mason_packages = {
	"bash-language-server",
	"css-lsp",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"eslint-lsp",
	"hadolint",
	"html-lsp",
	"intelephense",
	"json-lsp",
	"lua-language-server",
	"markdownlint",
	"nginx-language-server",
	"php-debug-adapter",
	"phpactor",
	"phpstan",
	"prettierd",
	"shellcheck",
	"shfmt",
	"stylua",
	"yamlfix",
}

M.lsp_servers = {
	"tsserver",
	"lua_ls",
	"eslint",
	"bashls",
	"yamlls",
	"jsonls",
	"cssls",
	"html",
	"intelephense",
	"phpactor",
}

M.typo3_lsp = function(lspconfig)
	local configs = require("lspconfig.configs")
	local util = require("lspconfig.util")
	configs.typo3 = {
		default_config = {
			cmd = { "/var/www/bluechip/.devel/lsp.sh" },
			filetypes = "*",
			root_dir = util.root_pattern("typo3_src"),
		},
		docs = {
			description = [[
https://github.com/Teddytrombone/ide-companion
            ]],
			default_config = {
				root_dir = [[util.root_pattern('typo3_src')]],
			},
		},
	}
end

M.php_root_dir = function(pattern)
	local util = require("lspconfig.util")
	local cwd = vim.uv.cwd()
	local root = util.root_pattern("composer.json", ".git")(pattern)

	if root == nil then
		return cwd
	end

	-- prefer cwd if root is a descendant
	return util.path.is_descendant(cwd, root) and cwd or root
end

M.setup = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("teddytrombone-lsp-attach", { clear = true }),
		callback = function(args)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("gD", vim.lsp.buf.declaration, "Goto declaration")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")
			map("<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
			map("<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
			map("<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List workspace folders")
			map("<space>rn", vim.lsp.buf.rename, "Rename")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			map("<A-f>", function()
				vim.lsp.buf.format({ async = true })
			end, "Format")

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup = vim.api.nvim_create_augroup("teddytrombone-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("teddytrombone-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "teddytrombone-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- The following code creates a keymap to toggle inlay hints in your
			-- code, if the language server you are using supports them
			--
			-- This may be unwanted, since they displace some of your code
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})
end

return M
