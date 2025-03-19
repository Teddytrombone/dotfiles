return {
	"mfussenegger/nvim-lint",
	opts = {
		linters = {
			phpcs = {
				args = {
					"--standard=PSR12",
					"-q",
					"--report=json",
					"-", -- need `-` at the end for stdin suppor't
				},
			},
		},
	},
}
