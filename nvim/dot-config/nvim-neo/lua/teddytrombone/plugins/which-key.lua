return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have_nerd_font and {} or {
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				C = "<C-…> ",
				M = "<M-…> ",
				D = "<D-…> ",
				S = "<S-…> ",
				CR = "<CR> ",
				Esc = "<Esc> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				NL = "<NL> ",
				BS = "<BS> ",
				Space = "<Space> ",
				Tab = "<Tab> ",
				F1 = "<F1>",
				F2 = "<F2>",
				F3 = "<F3>",
				F4 = "<F4>",
				F5 = "<F5>",
				F6 = "<F6>",
				F7 = "<F7>",
				F8 = "<F8>",
				F9 = "<F9>",
				F10 = "<F10>",
				F11 = "<F11>",
				F12 = "<F12>",
			},
		},
		plugins = { spelling = true },
		-- spec = {
		-- 	["g"] = { name = "+goto" },
		-- 	["gs"] = { name = "+surround" },
		-- 	["]"] = { name = "+next" },
		-- 	["["] = { name = "+prev" },
		-- 	["<leader><tab>"] = { name = "+tabs" },
		-- 	["<leader>b"] = { name = "+buffer" },
		-- 	["<leader>c"] = { name = "+code" },
		-- 	["<leader>f"] = { name = "+file/find" },
		-- 	["<leader>g"] = { name = "+git" },
		-- 	["<leader>gh"] = { name = "+hunks" },
		-- 	["<leader>q"] = { name = "+quit/session" },
		-- 	["<leader>s"] = { name = "+search" },
		-- 	["<leader>u"] = { name = "+ui" },
		-- 	["<leader>w"] = { name = "+windows" },
		-- 	["<leader>x"] = { name = "+diagnostics/quickfix" },
		-- },
	},
	-- config = function(_, opts)
	-- 	local wk = require("which-key")
	-- 	wk.setup(opts)
	-- 	wk.register(opts.defaults)
	-- end,
}
