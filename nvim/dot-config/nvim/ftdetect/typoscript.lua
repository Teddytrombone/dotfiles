vim.filetype.add({
	extension = {
		typoscript = "typoscript",
		tsconfig = "typoscript",
	},
	filename = {
		["ext_typoscript_setup.txt"] = "typoscript",
		["ext_typoscript_constants.txt"] = "typoscript",
	},
	pattern = {
		[".*/Configuration/TypoScript/.*"] = { "typoscript", { priority = 10 } },
		[".*/Configuration/[Tt][Ss][Cc]onfig/.*"] = { "typoscript", { priority = 10 } },
		[".*/Configuration/[Pp]age[Tt][Ss]/.*"] = { "typoscript", { priority = 10 } },
		[".*/ext/.*/static/.*%.txt"] = { "typoscript", { priority = 10 } },
		[".*/ext/.*/static/.*%.ts"] = { "typoscript", { priority = 10 } },
		[".*/fileadmin/typoscript/.*"] = { "typoscript", { priority = 10 } },
	},
})
