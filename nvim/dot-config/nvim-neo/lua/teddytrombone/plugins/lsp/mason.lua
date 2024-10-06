return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    opts = {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local utils = require("teddytrombone.utils.lsp")
        local mr = require("mason-registry")
        mr:on("package:install:success", function()
            vim.defer_fn(function()
                -- trigger FileType event to possibly load this newly installed LSP server
                require("lazy.core.handler.event").trigger({
                    event = "FileType",
                    buf = vim.api.nvim_get_current_buf(),
                })
            end, 100)
        end)

        local ensure_installed = {}
        vim.list_extend(ensure_installed, utils.lsp_servers)
        vim.list_extend(ensure_installed, utils.mason_packages)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    end,
}
