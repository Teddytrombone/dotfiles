local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'intelephense',
    'jsonls',
    'yamlls',
    'dockerls',
    'html',
    'ltex',
    'cssls',
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
end)

lsp.setup()
