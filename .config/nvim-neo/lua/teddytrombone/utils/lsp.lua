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

M.php_root_dir = function(pattern)
	local util = require("lspconfig.util")
	local cwd = vim.loop.cwd()
	local root = util.root_pattern("composer.json", ".git")(pattern)

	if root == nil then
		return cwd
	end

	-- prefer cwd if root is a descendant
	return util.path.is_descendant(cwd, root) and cwd or root
end

M.setup = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(args)
			local bufnr = args.buf

			vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto declaration" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto implementation" })
			vim.keymap.set(
				"n",
				"<C-k>",
				vim.lsp.buf.signature_help,
				{ buffer = bufnr, desc = "Signature documentation" }
			)
			vim.keymap.set(
				"n",
				"<space>wa",
				vim.lsp.buf.add_workspace_folder,
				{ buffer = bufnr, desc = "Add workspace folder" }
			)
			vim.keymap.set(
				"n",
				"<space>wr",
				vim.lsp.buf.remove_workspace_folder,
				{ buffer = bufnr, desc = "Remove workspace folder" }
			)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { buffer = bufnr, desc = "List workspace folders" })
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
			vim.keymap.set(
				{ "n", "v" },
				"<space>ca",
				vim.lsp.buf.code_action,
				{ buffer = bufnr, desc = "Code actions" }
			)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = bufnr, desc = "Format" })
		end,
	})
end

return M
