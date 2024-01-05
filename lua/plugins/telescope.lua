local keymap = vim.keymap

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

			local builtin = require("telescope.builtin")

			-- File pickers
			keymap.set("n", "<leader>ff", builtin.find_files, {})
			keymap.set("n", "<leader>fgf", builtin.git_files, {})
			keymap.set("n", "<leader>flg", builtin.live_grep, {})
			keymap.set("n", "<leader>fw", builtin.grep_string, {})
			keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})

			-- LSP pickers
			keymap.set("n", "<leader>flr", builtin.lsp_references, {})
			keymap.set("n", "<leader>fli", builtin.lsp_implementations, {})
			keymap.set("n", "<leader>fld", builtin.lsp_definitions, {})
			keymap.set("n", "<leader>fltd", builtin.lsp_type_definitions, {})

			-- Vim pickers
			keymap.set("n", "<leader>fb", builtin.buffers, {})
			keymap.set("n", "<leader>fh", builtin.help_tags, {})
			keymap.set("n", "<leader>:", builtin.commands, {})
			keymap.set("n", "<leader>fm", builtin.marks, {})
			keymap.set("n", "<leader>fq", builtin.quickfix, {})
			keymap.set("n", "<leader>fll", builtin.loclist, {})
			keymap.set("n", "<leader>fjl", builtin.jumplist, {})

			-- Git pickers
			keymap.set("n", "<leader>fgc", builtin.git_commits, {})
			keymap.set("n", "<leader>fgbc", builtin.git_bcommits, {})
			keymap.set("n", "<leader>fgbr", builtin.git_branches, {})
			keymap.set("n", "<leader>fgst", builtin.git_status, {})
			keymap.set("n", "<leader>fgsta", builtin.git_stash, {})

			-- Treesitter
			keymap.set("n", "<leader>ftree", builtin.treesitter, {})

			telescope.load_extension("ui-select")
			telescope.load_extension("notify")
		end,
	},
}
