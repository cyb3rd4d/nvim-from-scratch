return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	config = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_save_location = "~/.local/share/nvim/dadbod"

		-- Credits https://github.com/omerxx/dotfiles/blob/master/nvim/lua/config/dadbod.lua
		local function db_completion()
			require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		end

		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				vim.schedule(db_completion)
			end,
		})
	end,
}
