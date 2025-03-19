return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"moyiz/blink-emoji.nvim",
		},
		opts = {
			completion = {
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
			},
			sources = {
				default = {
					"emoji",
				},
				providers = {
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						max_items = 10,
						score_offset = 150, -- Tune by preference
					},
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		--   lazy = false,
		config = function()
			local luasnip = require("luasnip")
			local snip = luasnip.snippet
			local func = luasnip.function_node

			luasnip.add_snippets("all", {
				snip({
					trig = "date",
					namr = "Date",
					dscr = "Date in the form of YYYY-MM-DD",
				}, {
					func(function()
						return { os.date("%Y-%m-%d") }
					end, {}),
				}),
				snip({
					trig = "ts",
					namr = "Unix Timestamp",
					dscr = "Current Unix Timestamp",
				}, {
					func(function()
						local timestamp = os.time()
						return "" .. timestamp
					end, {}),
				}),
			})
		end,
	},
}
