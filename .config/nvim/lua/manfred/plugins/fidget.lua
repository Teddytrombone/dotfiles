return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
        -- options
    },
    config = function()
        require("fidget").setup {
            -- options
        }
    end
}
