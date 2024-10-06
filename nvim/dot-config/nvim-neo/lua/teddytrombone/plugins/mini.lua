return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>bd",
			function()
				local bd = require("mini.bufremove").delete
				if vim.bo.modified then
					local choice =
						vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
					if choice == 1 then -- Yes
						vim.cmd.write()
						bd(0)
					elseif choice == 2 then -- No
						bd(0, true)
					end
				else
					bd(0)
				end
			end,
			desc = "Delete Buffer",
		},
        -- stylua: ignore
        { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
		{
			"<leader>up",
			function()
				local Util = require("lazy.core.util")
				vim.g.minipairs_disable = not vim.g.minipairs_disable
				if vim.g.minipairs_disable then
					Util.warn("Disabled auto pairs", { title = "Option" })
				else
					Util.info("Enabled auto pairs", { title = "Option" })
				end
			end,
			desc = "Toggle auto pairs",
		},
	},
	config = function()
		require("mini.pairs").setup()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			custom_textobjects = {
				o = ai.gen_spec.treesitter({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}, {}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
			},
		})

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		-- local statusline = require 'mini.statusline'
		-- set use_icons to true if you have a Nerd Font
		-- statusline.setup { use_icons = vim.g.have_nerd_font }

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- return '%2l:%-2v'
		-- end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}