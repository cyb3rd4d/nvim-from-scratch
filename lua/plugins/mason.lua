return {
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { 'VonHeikemen/lsp-zero.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      require('mason-lspconfig').setup({
        ensure_installed = { "gopls", "lua_ls", "bashls", "tsserver" },
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end
  },
}
