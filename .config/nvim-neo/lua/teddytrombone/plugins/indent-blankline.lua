return {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- event = "LazyFile",
    -- See `:help ibl`
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
        },
    },
}
