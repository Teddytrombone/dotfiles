return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			["yaml"] = { { "yamlfix", "yamlfmt" } },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters = {
			yamlfix = {
				env = {
					YAMLFIX_EXPLICIT_START = 0,
					YAMLFIX_WHITELINE = 1,
				},
			},
		},
	},
}
