return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {},
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "docker_compose_language_service",
          "dockerls",
          "gopls",
          "lua_ls",
          "terraformls",
          "tsserver",
          "rust_analyzer",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "folke/neodev.nvim",   opts = {} },
    },
    config = function()
      require("neodev").setup({
        library = {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local lsp = vim.lsp

      local handlers = {
        ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" }),
      }

      lspconfig.lua_ls.setup({
        handlers = handlers,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      lspconfig.docker_compose_language_service.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.dockerls.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.bashls.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.tsserver.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.rust_analyzer.setup({
        handlers = handlers,
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({
        handlers = handlers,
        capabilities = capabilities,
      })
    end,
  },
}
