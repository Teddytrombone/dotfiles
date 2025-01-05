if vim.fn.isdirectory("/usr/share/nvim/site/") == 1 then
	return { "ghostty", dir = "/usr/share/nvim/site/", lazy = false }
end
return {}
