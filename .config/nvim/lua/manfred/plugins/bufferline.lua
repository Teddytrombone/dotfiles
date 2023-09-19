return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = 'UIEnter',
  keys = {
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Go to next buffer' },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
      always_show_bufferline = true,
    },
  },
  config = function()
    require('bufferline').setup {
    }
  end
}
