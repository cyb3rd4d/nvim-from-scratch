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
				ensure_installed = { "gopls", "lua_ls", "bashls", "tsserver", "rust_analyzer" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("neodev").setup()
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
		end,
	},
}
