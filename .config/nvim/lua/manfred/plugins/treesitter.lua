return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
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
	  },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
}
