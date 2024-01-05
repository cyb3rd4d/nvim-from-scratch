return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim", config = true },
			{ "rcarriga/nvim-notify" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({})
			telescope.load_extension("ui-select")
			telescope.load_extension("notify")
		end,
	},
}
