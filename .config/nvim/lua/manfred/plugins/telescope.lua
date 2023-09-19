return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                  require('telescope').load_extension('fzf')
            end,
        },
    },
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
