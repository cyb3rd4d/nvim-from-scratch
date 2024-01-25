return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim", config = true },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "rcarriga/nvim-notify" },
		},
		config = function()
			local telescope = require("telescope")
			--    local trouble = require("trouble.providers.telescope")
			--
			-- telescope.setup({
			--      defaults = {
			--        mappings = {
			--          i = { ["<C-t>"] = trouble.open_with_trouble },
			--          n = { ["<C-t>"] = trouble.open_with_trouble },
			--        },
			--      },
			--    })
			telescope.setup({})
			telescope.load_extension("ui-select")
			telescope.load_extension("notify")
			telescope.load_extension("dap")
		end,
	},
}
