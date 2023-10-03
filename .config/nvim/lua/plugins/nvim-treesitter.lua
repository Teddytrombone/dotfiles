return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
	      "c",
          "cpp",
	      "php",
	      "lua",
	      "python",
	      "html",
	      "css",
	      "scss",
	      "latex",
	      "bash",
	      "gitattributes",
	      "gitignore",
	      "javascript",
	      "json",
	      "json5",
	      "regex",
	      "yaml",
      })
    end,
  },
}
