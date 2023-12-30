return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = function()
			local lsp_zero = require("lsp-zero")
			local lua_opts = lsp_zero.nvim_lua_ls()
			lsp_zero.extend_lspconfig()
			require("lspconfig").lua_ls.setup(lua_opts)

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
				lsp_zero.buffer_autoformat()
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			end)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
}
