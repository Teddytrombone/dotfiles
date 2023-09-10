return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = function()
        require('telescope').setup {
            pickers = {
                find_files = {
                    follow = true
                }
            }
        }
    end
}
