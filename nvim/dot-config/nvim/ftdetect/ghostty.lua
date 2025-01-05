vim.filetype.add({
	pattern = {
		[".*/%.config/ghostty/.*"] = { "ghostty", { priority = 10 } },
		[".*/dot%-config/ghostty/.*"] = { "ghostty", { priority = 10 } },
	},
})
